part of 'search_bloc.dart';

class SearchState extends Equatable {
  final String textToSearch;
  final FormzStatus status;
  final BookData data;
  final int page;

  const SearchState({
    this.textToSearch = "",
    this.status = FormzStatus.pure,
    this.data,
    this.page = 1,
  });

  SearchState copyWith({
    String textToSearch,
    FormzStatus status,
    BookData data,
    int page,
  }) =>
      SearchState(
        textToSearch: textToSearch ?? this.textToSearch,
        status: status ?? this.status,
        data: data ?? this.data,
        page: page ?? this.page,
      );

  @override
  List<Object> get props => [
        textToSearch,
        status,
        data,
        page,
      ];
}
