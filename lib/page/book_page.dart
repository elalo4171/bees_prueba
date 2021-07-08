import 'package:bees_prueba/model/book.dart';
import 'package:bees_prueba/model/books.dart';
import 'package:bees_prueba/tools/responsive.dart';
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
    final _theme = Theme.of(context);
    final _responsive = Responsive(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.book.title, style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
        ),
        body: thisBook == null
            ? Center(child: CircularProgressIndicator())
            : ListView(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(80.0),
                      child: Container(
                        child: Image.network(
                          thisBook.image,
                          height: 300,
                          fit: BoxFit.contain,
                        ),
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(thisBook.title,
                          style: _theme.textTheme.headline5
                              .copyWith(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: _responsive.widthCustom(.9),
                        child: Text(thisBook.desc,
                            textAlign: TextAlign.center,
                            style: _theme.textTheme.bodyText2
                                .copyWith(color: Colors.black54)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text(
                            thisBook.pages,
                            style: _theme.textTheme.headline6
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                )
                                .copyWith(color: _theme.accentColor),
                          ),
                          Text("Pages"),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            thisBook.price,
                            style: _theme.textTheme.headline6
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                )
                                .copyWith(color: _theme.accentColor),
                          ),
                          Text("Price"),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            thisBook.language,
                            style: _theme.textTheme.headline6
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                )
                                .copyWith(color: _theme.accentColor),
                          ),
                          Text("Languaae"),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ListTile(
                    title: Text(
                      "Authors",
                      style: _theme.textTheme.headline6,
                    ),
                    subtitle: Text(
                      thisBook.authors,
                      style: TextStyle(color: _theme.accentColor),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      thisBook.publisher,
                      style: _theme.textTheme.headline6,
                    ),
                    subtitle: Text(
                      thisBook.isbn13,
                      style: TextStyle(color: _theme.accentColor),
                    ),
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
