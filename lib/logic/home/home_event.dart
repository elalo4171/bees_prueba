part of 'home_bloc.dart';

abstract class HomeEvent {
  const HomeEvent();
}

class LoadFirstBooks extends HomeEvent {}

class ChangeTextToSearch extends HomeEvent {
  final String text;

  ChangeTextToSearch(this.text);
}

class SearchText extends HomeEvent {}

class ChangeShowInBox extends HomeEvent {}
