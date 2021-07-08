import 'dart:async';

import 'package:bees_prueba/model/books.dart';
import 'package:bees_prueba/tools/enums.dart';
import 'package:bees_prueba/tools/rest_api.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final RestApi restApi;
  HomeBloc(this.restApi) : super(HomeState()) {
    this.add(LoadFirstBooks());
  }

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is LoadFirstBooks) {
      yield state.copyWith(requestStatus: RequestStatus.waiting);
      final bookData = await restApi.loadBooks();
      yield state.copyWith(
        bookData: bookData,
        homeStatus: HomeEnum.withNewBooks,
        requestStatus: RequestStatus.success,
      );
    }
    if (event is ChangeTextToSearch) {
      yield state.copyWith(textToSearch: event.text);
    }
    // if (event is SearchText) {
    //   if (state.textToSearch.length > 0) {
    //     List<String> temp = state.lastSearch.toList();
    //     yield state.copyWith(requestStatus: RequestStatus.waiting);
    //     temp.add(state.textToSearch);
    //     final bookData = await restApi.searchBooks(state.textToSearch);
    //     yield state.copyWith(
    //       bookData: bookData,
    //       lastSearch: temp,
    //       homeStatus: HomeEnum.withSearch,
    //       requestStatus: RequestStatus.success,
    //     );
    //   }
    // }
    if (event is ChangeShowInBox) {
      yield state.copyWith(showInBox: !state.showInBox);
    }
  }
}
