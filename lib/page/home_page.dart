import 'package:animate_do/animate_do.dart';
import 'package:bees_prueba/logic/home/home_bloc.dart';
import 'package:bees_prueba/model/books.dart';
import 'package:bees_prueba/tools/enums.dart';
import 'package:bees_prueba/tools/responsive.dart';
import 'package:bees_prueba/tools/rest_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:searchfield/searchfield.dart';

class HomePage extends StatelessWidget {
  final _restApi = RestApi();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(_restApi),
      child: BuildHome(),
    );
  }
}

class BuildHome extends StatelessWidget {
  const BuildHome({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _responsive = Responsive(context);
    final _homeBloc = context.watch<HomeBloc>();
    final _theme = Theme.of(context);

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Libros",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
        ),
        body: SafeArea(
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state.homeStatus == HomeEnum.empty) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Column(
                children: [
                  FadeInDown(
                    delay: Duration(milliseconds: 800),
                    child: Container(
                      color: _theme.primaryColor,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 25),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context, "search");
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(
                                        15,
                                      ),
                                    ),
                                    width: _responsive.widthCustom(.9),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        hintText: "Buscar",
                                        prefixIcon: Icon(Icons.search),
                                        border: InputBorder.none,
                                      ),
                                      enabled: false,
                                      onTap: () {
                                        Navigator.pushNamed(context, "search");
                                      },
                                      onEditingComplete: () {},
                                      onChanged: (v) {
                                        if (v.isNotEmpty) {
                                          _homeBloc.add(ChangeTextToSearch(v));
                                        } else {
                                          FocusScope.of(context).unfocus();
                                          if (state.homeStatus ==
                                              HomeEnum.withSearch) {
                                            _homeBloc.add(LoadFirstBooks());
                                          }
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  FadeInRight(
                    delay: Duration(milliseconds: 800),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          "Popular",
                          style: _theme.textTheme.subtitle2.copyWith(
                            fontSize: 20,
                            color: _theme.accentColor,
                          ),
                        ),
                        Spacer(),
                        BlocBuilder<HomeBloc, HomeState>(
                          builder: (context, state) {
                            return IconButton(
                                onPressed: () {
                                  _homeBloc.add(ChangeShowInBox());
                                },
                                icon: Icon(
                                  Icons.fullscreen_exit_sharp,
                                  color: state.showInBox
                                      ? _theme.accentColor
                                      : null,
                                ));
                          },
                        ),
                        SizedBox(
                          width: 15,
                        ),
                      ],
                    ),
                  ),
                  state.requestStatus == RequestStatus.waiting
                      ? Center(child: CircularProgressIndicator())
                      : Expanded(
                          child: BlocBuilder<HomeBloc, HomeState>(
                            builder: (context, state) {
                              if (state.bookData.books.length == 0) {
                                return Center(
                                    child: Text(
                                        "There are no books on the shelf"));
                              }
                              return FadeInRight(
                                  delay: Duration(milliseconds: 800),
                                  child: !state.showInBox
                                      ? ListView.builder(
                                          itemCount:
                                              state.bookData.books.length,
                                          itemBuilder: (context, index) {
                                            BookElement book =
                                                state.bookData.books[index];
                                            return BookWidget(
                                              book: book,
                                              index: index,
                                            );
                                          },
                                        )
                                      : GridView.builder(
                                          gridDelegate:
                                              SliverGridDelegateWithMaxCrossAxisExtent(
                                                  maxCrossAxisExtent: 250,
                                                  childAspectRatio: .7,
                                                  crossAxisSpacing: 0,
                                                  mainAxisSpacing: 0),
                                          itemCount:
                                              state.bookData.books.length,
                                          itemBuilder: (context, index) {
                                            BookElement book =
                                                state.bookData.books[index];
                                            return BookWidgetGrid(
                                              book: book,
                                              index: index,
                                            );
                                          },
                                        ));
                            },
                          ),
                        ),
                ],
              );
            },
          ),
        ));
  }
}

class BookWidget extends StatelessWidget {
  const BookWidget({
    Key key,
    @required this.book,
    @required this.index,
  }) : super(key: key);

  final BookElement book;
  final int index;

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _responsive = Responsive(context);
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, "book", arguments: book);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            book.image,
            height: 100,
            width: _responsive.widthCustom(.2),
          ),
          SizedBox(
            width: _responsive.widthCustom(.7),
            child: ListTile(
              title: Text(book.title),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.subtitle,
                    style: TextStyle(color: _theme.primaryColor),
                  ),
                  Text(
                    book.price,
                    style: TextStyle(color: _theme.accentColor),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BookWidgetGrid extends StatelessWidget {
  const BookWidgetGrid({
    Key key,
    @required this.book,
    @required this.index,
  }) : super(key: key);

  final BookElement book;
  final int index;

  @override
  Widget build(BuildContext context) {
    final _responsive = Responsive(context);
    final _theme = Theme.of(context);
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, "book", arguments: book);
      },
      child: FadeIn(
        delay: Duration(milliseconds: 200),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              book.image,
              height: 80,
              width: _responsive.widthCustom(.2),
            ),
            SizedBox(
              width: _responsive.widthCustom(.5),
              child: ListTile(
                title: Text(book.title),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      book.subtitle,
                      style: TextStyle(color: _theme.primaryColor),
                    ),
                    Text(
                      book.price,
                      style: TextStyle(color: _theme.accentColor),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
