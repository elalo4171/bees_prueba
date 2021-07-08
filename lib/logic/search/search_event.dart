part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class ChangeText extends SearchEvent {
  final String text;

  ChangeText(this.text);
}

class SearchText extends SearchEvent {}
