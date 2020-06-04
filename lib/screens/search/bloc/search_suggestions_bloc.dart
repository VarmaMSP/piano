import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:phenopod/models/search_suggestion.dart';
import 'package:phenopod/utils/request.dart';
import 'package:rxdart/rxdart.dart';

part 'search_suggestions_event.dart';
part 'search_suggestions_state.dart';

class SearchSuggestionsBloc
    extends Bloc<SearchSuggestionsEvent, SearchSuggestionsState> {
  @override
  SearchSuggestionsState get initialState => SearchSuggestionsInitial();

  @override
  Stream<Transition<SearchSuggestionsEvent, SearchSuggestionsState>>
      transformEvents(Stream<SearchSuggestionsEvent> events, transitionFn) {
    return super.transformEvents(
      events.debounceTime(Duration(milliseconds: 300)),
      transitionFn,
    );
  }

  @override
  Stream<SearchSuggestionsState> mapEventToState(
    SearchSuggestionsEvent event,
  ) async* {
    if (event is SearchTextUpdated) {
      final searchText = event.searchText.trim();
      if (searchText.isNotEmpty) {
        final response = await makeRequest(
          method: 'GET',
          path: '/suggest?query=$searchText',
        );

        yield SearchSuggestionsLoaded(suggestions: response.searchSuggestions);
      }
    }
  }
}
