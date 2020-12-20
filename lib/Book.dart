class Book {
  String book_id;
  String book_title;
  String author;
  String price;
  String description;
  String rating;
  String publisher;
  String isbn;
  String cover;

  Book(
    String book_id,
    String book_title,
    String author,
    String price,
    String description,
    String rating,
    String publisher,
    String isbn,
    String cover,
  ) {
    this.book_id = book_id;
    this.book_title = book_title;
    this.author = author;
    this.price = price;
    this.description = description;
    this.rating = rating;
    this.publisher = publisher;
    this.isbn = isbn;
    this.cover = cover;
  }
}
