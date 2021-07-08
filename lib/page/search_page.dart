import 'package:bees_prueba/logic/search/search_bloc.dart';
import 'package:bees_prueba/model/books.dart';
import 'package:bees_prueba/page/home_page.dart';
import 'package:bees_prueba/tools/responsive.dart';
import 'package:bees_prueba/tools/rest_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class SearchPage extends StatelessWidget {
  final RestApi restApi = RestApi();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchBloc(restApi),
      child: BuildSearch(),
    );
  }
}

class BuildSearch extends StatefulWidget {
  @override
  _BuildSearchState createState() => _BuildSearchState();
}

class _BuildSearchState extends State<BuildSearch> {
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.offset ==
          scrollController.position.maxScrollExtent) {
        final _searchBloc = context.read<SearchBloc>();
        _searchBloc.add(LoadMore());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final _searchBloc = context.watch<SearchBloc>();
    final _responsive = Responsive(context);
    final _theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Busqueda",
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: _theme.primaryColor,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                              15,
                            ),
                          ),
                          width: _responsive.widthCustom(.9),
                          child: TextFormField(
                            autofocus: true,
                            decoration: InputDecoration(
                              hintText: "Buscar",
                              prefixIcon: Icon(Icons.search),
                              border: InputBorder.none,
                              semanticCounterText: "fewf",
                            ),
                            onEditingComplete: () {
                              _searchBloc.add(SearchText());
                            },
                            onChanged: (v) {
                              _searchBloc.add(ChangeText(v));
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                if (state.status == FormzStatus.pure) {
                  return Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: Text("Busca algo :)"),
                      ),
                    ],
                  );
                } else {
                  if (state.status == FormzStatus.submissionInProgress) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Center(
                          child: CircularProgressIndicator(),
                        ),
                      ],
                    );
                  }
                  if (state.status == FormzStatus.submissionSuccess) {
                    if (state.data.books.length == 0) {
                      return Column(
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Center(
                            child: Text(
                                "Lamentablemente no hay libros con ese titulo"),
                          ),
                        ],
                      );
                    }
                  }
                  return Expanded(
                    child: ListView.builder(
                      addAutomaticKeepAlives: true,
                      addRepaintBoundaries: false,
                      controller: scrollController,
                      itemCount: state.data.books.length,
                      itemBuilder: (context, index) {
                        BookElement book = state.data.books[index];
                        return BookWidget(
                          book: book,
                          index: index,
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
