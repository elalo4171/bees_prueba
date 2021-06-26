import 'package:bees_prueba/logic/home/home_bloc.dart';
import 'package:bees_prueba/model/books.dart';
import 'package:bees_prueba/tools/enums.dart';
import 'package:bees_prueba/tools/rest_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  final _restApi = RestApi();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(_restApi),
      lazy: false,
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
    return Scaffold(body: BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state.homeStatus == HomeEnum.empty) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView.builder(
            itemCount: state.bookData.books.length,
            itemBuilder: (context, index) {
              BookElement book = state.bookData.books[index];
              return ListTile(
                title: Text(book.title),
                subtitle: Text(book.subtitle),
              );
            },
          );
        }
      },
    ));
  }
}
