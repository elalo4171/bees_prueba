part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState({
    this.bookData,
    this.homeStatus = HomeEnum.empty,
    this.requestStatus = RequestStatus.empty,
  });

  final BookData bookData;
  final HomeEnum homeStatus;
  final RequestStatus requestStatus;

  copyWith({
    BookData bookData,
    HomeEnum homeStatus,
    RequestStatus requestStatus,
  }) =>
      HomeState(
        bookData: bookData ?? this.bookData,
        homeStatus: homeStatus ?? this.homeStatus,
        requestStatus: requestStatus ?? this.requestStatus,
      );

  @override
  List<Object> get props => [
        bookData,
        homeStatus,
        requestStatus,
      ];
}
