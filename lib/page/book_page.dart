import 'package:bees_prueba/model/books.dart';
import 'package:flutter/material.dart';

class BookPage extends StatelessWidget {
  const BookPage(
    this.book, {
    Key key,
  }) : super(key: key);

  final BookElement book;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(book.title),
        ),
        body: Center(child: Text("Book")));
  }
}
