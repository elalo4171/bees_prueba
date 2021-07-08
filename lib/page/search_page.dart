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

class BuildSearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _searchBloc = context.watch<SearchBloc>();
    final _responsive = Responsive(context);
    final _theme = Theme.of(context);
    return Scaffold(
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
                  return Expanded(
                    child: ListView.builder(
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
