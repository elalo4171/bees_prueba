part of 'search_bloc.dart';

class SearchState extends Equatable {
  final String textToSearch;
  final FormzStatus status;
  final BookData data;

  const SearchState({
    this.textToSearch = "",
    this.status = FormzStatus.pure,
    this.data,
  });

  SearchState copyWith({
    String textToSearch,
    FormzStatus status,
    BookData data,
  }) =>
      SearchState(
        textToSearch: textToSearch ?? this.textToSearch,
        status: status ?? this.status,
        data: data ?? this.data,
      );

  @override
  List<Object> get props => [
        textToSearch,
        status,
        data,
      ];
}
