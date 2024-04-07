import 'package:bookshop_fe/models/user.dart';
import 'package:bookshop_fe/providers/login.dart';
import 'package:bookshop_fe/services/backend_service.dart';
import 'package:bookshop_fe/widgets/custom_side_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    super.key,
  });

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  late Future<User> _profileData;

  // void _changeAvatar() {
  //   try {
  //     final response = await UserService.updateProfilePicture(newUrl);
  //     if (response['message'] == 'Profile picture URL updated successfully') {
  //       updateProfilePicture(newUrl);
  //       // Show success message to user (optional)
  //     }
  //   } on Exception catch (e) {
  //     // Handle error (e.g., display error message to user)
  //     print(e.toString());
  //   }
  // }
  Future<User> fetchProfile() async {
    final lp = Provider.of<LoginProvider>(context, listen: false);
    return BackendService.getProfile(lp.accessToken);
  }

  @override
  void initState() {
    super.initState();
    _profileData = fetchProfile();
  }

  @override
  Widget build(BuildContext context) {
    final lp = Provider.of<LoginProvider>(context);
    var name = lp.currentUser.fullName;
    var email = lp.currentUser.email;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      drawer: const CustomSideMenu(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
                onTap: () {
                  // _changeAvatar();
                },
                child: FutureBuilder<User>(
                    future: _profileData,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return CircleAvatar(
                          radius: 60,
                          backgroundImage:
                              NetworkImage(snapshot.data!.profilePicUrl),
                        );
                      } else if (snapshot.hasError) {
                        print(snapshot.error);
                        return const CircleAvatar(
                          radius: 60,
                          backgroundImage:
                              AssetImage('assets/default-profile.png'),
                        );
                      }
                      return const CircularProgressIndicator();
                    })),
            const SizedBox(height: 20),
            Text(
              'Name: $name',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 10),
            Text(
              'Email: $email',
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
