part of 'search_suggestions_bloc.dart';

abstract class SearchSuggestionsState extends Equatable {
  const SearchSuggestionsState();

  @override
  List<Object> get props => [];
}

class SearchSuggestionsInitial extends SearchSuggestionsState {}

class SearchSuggestionsLoaded extends SearchSuggestionsState {
  SearchSuggestionsLoaded({this.suggestions});

  final List<SearchSuggestion> suggestions;

  @override
  List<Object> get props => [suggestions];

  @override
  String toString() =>
      'SearchSuggestionsLoaded { count: ${suggestions.length}}';
}

class SearchSuggestionsError extends SearchSuggestionsState {}
