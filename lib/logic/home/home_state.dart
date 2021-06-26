part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState({
    this.bookData,
    this.homeStatus = HomeEnum.empty,
    this.requestStatus = RequestStatus.empty,
    this.textToSearch = "",
    this.lastSearch = const [],
  });

  final BookData bookData;
  final HomeEnum homeStatus;
  final RequestStatus requestStatus;
  final String textToSearch;
  final List<String> lastSearch;

  copyWith({
    BookData bookData,
    HomeEnum homeStatus,
    RequestStatus requestStatus,
    String textToSearch,
    List<String> lastSearch,
  }) =>
      HomeState(
        bookData: bookData ?? this.bookData,
        homeStatus: homeStatus ?? this.homeStatus,
        requestStatus: requestStatus ?? this.requestStatus,
        textToSearch: textToSearch ?? this.textToSearch,
        lastSearch: lastSearch ?? this.lastSearch,
      );

  @override
  List<Object> get props => [
        bookData,
        homeStatus,
        requestStatus,
        textToSearch,
        lastSearch,
      ];
}
