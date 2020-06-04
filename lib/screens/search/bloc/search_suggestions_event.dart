part of 'search_suggestions_bloc.dart';

abstract class SearchSuggestionsEvent extends Equatable {
  const SearchSuggestionsEvent();

  @override
  List<Object> get props => [];
}

class SearchTextUpdated extends SearchSuggestionsEvent {
  SearchTextUpdated({this.searchText});

  final String searchText;

  @override
  List<Object> get props => [searchText];
}
