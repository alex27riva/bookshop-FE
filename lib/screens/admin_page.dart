import 'package:bookshop_fe/models/book.dart';
import 'package:bookshop_fe/providers/login.dart';
import 'package:bookshop_fe/services/backend_service.dart';
import 'package:bookshop_fe/widgets/admin_list_tile.dart';
import 'package:bookshop_fe/widgets/custom_side_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<Book> books = [];

  // New book data
  String _title = "";
  String _author = "";
  double _price = 0.0;
  String _coverUrl = "";

  // Sample book data
  static const String sampleTitle = "OAuth 2.0 Simplified";
  static const String sampleAuthor = "Aaron Parecki";
  static const String samplePrice = "32.99";
  static const String sampleImageUrl =
      "https://i.postimg.cc/BQHxT1Jd/oauth2-simplified.jpg";

  @override
  Widget build(BuildContext context) {
    final lp = Provider.of<LoginProvider>(context, listen: false);
    final scaffoldMessengerState = ScaffoldMessenger.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin page'),
      ),
      drawer: const CustomSideMenu(),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0), // adjust border radius
              border: Border.all(
                  color: Colors.green), // adjust color and width as needed
            ),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Text(
                  "Add a new book",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextFormField(
                        initialValue: sampleTitle,
                        decoration: const InputDecoration(
                          labelText: "Title",
                        ),
                        validator: (value) =>
                            value!.isEmpty ? "Please enter a title" : null,
                        onSaved: (value) => _title = value!,
                      ),
                      TextFormField(
                        initialValue: sampleAuthor,
                        decoration: const InputDecoration(
                          labelText: "Author",
                        ),
                        validator: (value) =>
                            value!.isEmpty ? "Please enter an author" : null,
                        onSaved: (value) => _author = value!,
                      ),
                      TextFormField(
                        initialValue: samplePrice,
                        decoration: const InputDecoration(
                          labelText: "Price",
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter a price";
                          } else {
                            double? price = double.tryParse(value);
                            if (price == null || price < 0) {
                              return "Please enter a valid price";
                            }
                            return null;
                          }
                        },
                        onSaved: (value) => _price = double.parse(value!),
                      ),
                      TextFormField(
                        initialValue: sampleImageUrl,
                        decoration: const InputDecoration(
                          labelText: "Cover image url",
                        ),
                        keyboardType: TextInputType.url,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter cover url";
                          }
                          return null;
                        },
                        onSaved: (value) => _coverUrl = value!,
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            var resp = await BackendService.adminBookAdd(
                                lp.accessToken,
                                _title,
                                _author,
                                _price,
                                _coverUrl);
                            if (resp.statusCode == 201) {
                              scaffoldMessengerState
                                  .showSnackBar(const SnackBar(
                                content: Text('Book added successfully'),
                                duration: Duration(seconds: 1),
                              ));
                            } else if (resp.statusCode == 409) {
                              scaffoldMessengerState
                                  .showSnackBar(const SnackBar(
                                content: Text('Book already exist'),
                                backgroundColor: Colors.red,
                                duration: Duration(seconds: 1),
                              ));
                            }
                          }
                          // refresh page
                          setState(() {});
                        },
                        child: const Text("Add Book"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.only(top: 10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                // adjust border radius
                border: Border.all(
                    color:
                        Colors.redAccent), // adjust color and width as needed
              ),
              child: Column(
                children: [
                  const Text(
                    "Remove a book",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                  ),
                  FutureBuilder<List<Book>>(
                    future: BackendService.fetchBooks(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else {
                        books = snapshot.data!;
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: books.length,
                            itemBuilder: (context, index) {
                              final book = books[index];
                              return AdminListTile(
                                book: book,
                                onDelete: () => _handleDeleteBook(book.id),
                              );
                            });
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleDeleteBook(int bookId) {
    // Remove book from the list
    final lp = Provider.of<LoginProvider>(context, listen: false);
    final scaffoldMessengerState = ScaffoldMessenger.of(context);
    setState(() async {
      books.removeWhere((book) => book.id == bookId);
      var resp = await BackendService.adminBookDelete(lp.accessToken, bookId);
      if (resp.statusCode == 200) {
        scaffoldMessengerState.showSnackBar(const SnackBar(
          content: Text('Book deleted successfully'),
          duration: Duration(seconds: 1),
        ));
      } else {
        scaffoldMessengerState.showSnackBar(const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Error deleting book'),
          duration: Duration(seconds: 1),
        ));
      }
    });
  }
}
