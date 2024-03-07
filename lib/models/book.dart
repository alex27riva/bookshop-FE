class Book {
  final String title;
  final String author;
  final String coverImageUrl;

  Book(this.title, this.author, this.coverImageUrl);

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      json['title'] as String,
      json['author'] as String,
      json['cover_image_url'] as String,
    );
  }
}
