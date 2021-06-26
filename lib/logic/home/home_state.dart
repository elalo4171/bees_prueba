part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState({this.bookData});

  final BookData bookData;

  copyWith({BookData bookData}) => HomeState(
        bookData: bookData ?? this.bookData,
      );

  @override
  List<Object> get props => [
        bookData,
      ];
}
