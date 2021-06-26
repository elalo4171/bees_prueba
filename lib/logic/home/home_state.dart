part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState({
    this.bookData,
    this.homeStatus = HomeEnum.empty,
    this.requestStatus = RequestStatus.empty,
    this.textToSearch = "",
  });

  final BookData bookData;
  final HomeEnum homeStatus;
  final RequestStatus requestStatus;
  final String textToSearch;

  copyWith({
    BookData bookData,
    HomeEnum homeStatus,
    RequestStatus requestStatus,
    String textToSearch,
  }) =>
      HomeState(
        bookData: bookData ?? this.bookData,
        homeStatus: homeStatus ?? this.homeStatus,
        requestStatus: requestStatus ?? this.requestStatus,
        textToSearch: textToSearch ?? this.textToSearch,
      );

  @override
  List<Object> get props => [
        bookData,
        homeStatus,
        requestStatus,
        textToSearch,
      ];
}
