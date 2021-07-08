import 'dart:async';

import 'package:bees_prueba/model/books.dart';
import 'package:bees_prueba/tools/rest_api.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc(this.restApi) : super(SearchState());
  final RestApi restApi;

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is ChangeText) {
      yield state.copyWith(textToSearch: event.text);
    }
    if (event is SearchText) {
      if (state.textToSearch.length > 0) {
        yield state.copyWith(status: FormzStatus.submissionInProgress);
        final bookData = await restApi.searchBooks(state.textToSearch, 0);
        yield state.copyWith(
          data: bookData,
          status: FormzStatus.submissionSuccess,
        );
      }
    }
    if (event is LoadMore) {
      yield state.copyWith(page: state.page + 1);
      if (state.textToSearch.length > 0) {
        final bookData =
            await restApi.searchBooks(state.textToSearch, state.page);
        BookData bookDataTemp = state.data;
        bookDataTemp.books.addAll(bookData.books);
        yield state.copyWith(
          data: bookDataTemp,
          status: FormzStatus.submissionSuccess,
        );
      }
    }
  }
}
