import 'package:bees_prueba/model/book.dart';
import 'package:bees_prueba/model/books.dart';
import 'package:bees_prueba/tools/rest_api.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BookPage extends StatefulWidget {
  const BookPage(
    this.book, {
    Key key,
  }) : super(key: key);

  final BookElement book;

  @override
  _BookPageState createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  Book thisBook;
  RestApi restApi = RestApi();
  @override
  void initState() {
    loadBook();
    super.initState();
  }

  Future<void> loadBook() async {
    thisBook = await restApi.getBook(widget.book.isbn13);
    setState(() {});
  }

  void _launchURL() async => await canLaunch(thisBook.url)
      ? await launch(thisBook.url)
      : throw 'Could not launch $thisBook.url';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.book.title, style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: thisBook == null
            ? Center(child: CircularProgressIndicator())
            : ListView(
                children: [
                  Container(
                      child: Image.network(
                    thisBook.image,
                    height: 250,
                  )),
                  ListTile(
                    title: Text(thisBook.title),
                    subtitle: Text(thisBook.desc),
                  ),
                  ListTile(
                    title: Text("Authors"),
                    subtitle: Text(thisBook.authors),
                  ),
                  ListTile(
                    title: Text(thisBook.publisher),
                    subtitle: Text(thisBook.isbn13),
                  ),
                  ListTile(
                    title: Text("Price"),
                    subtitle: Text(thisBook.price),
                  ),
                  ListTile(
                    title: Text("Language"),
                    subtitle: Text(thisBook.language),
                  ),
                  ListTile(
                    title: Text("Pages"),
                    subtitle: Text(thisBook.pages),
                  ),
                  TextButton(
                    child: Text("Show in browser"),
                    onPressed: () {
                      _launchURL();
                    },
                  )
                ],
              ));
  }
}
