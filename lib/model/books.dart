// To parse this JSON data, do
//
//     final book = bookFromJson(jsonString);

import 'dart:convert';

BookData bookFromJson(String str) => BookData.fromJson(json.decode(str));

String bookToJson(BookData data) => json.encode(data.toJson());

class BookData {
  BookData({
    this.error,
    this.total,
    this.books,
  });

  String error;
  String total;
  List<BookElement> books;

  factory BookData.fromJson(Map<String, dynamic> json) => BookData(
        error: json["error"],
        total: json["total"],
        books: List<BookElement>.from(
            json["books"].map((x) => BookElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "total": total,
        "books": List<dynamic>.from(books.map((x) => x.toJson())),
      };
}

class BookElement {
  BookElement({
    this.title,
    this.subtitle,
    this.isbn13,
    this.price,
    this.image,
    this.url,
  });

  String title;
  String subtitle;
  String isbn13;
  String price;
  String image;
  String url;

  factory BookElement.fromJson(Map<String, dynamic> json) => BookElement(
        title: json["title"],
        subtitle: json["subtitle"],
        isbn13: json["isbn13"],
        price: json["price"],
        image: json["image"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "subtitle": subtitle,
        "isbn13": isbn13,
        "price": price,
        "image": image,
        "url": url,
      };
}
