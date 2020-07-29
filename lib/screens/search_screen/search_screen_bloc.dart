// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:rxdart/rxdart.dart';

// Project imports:
import 'package:phenopod/models/main.dart';
import 'package:phenopod/store/store.dart';

// This Bloc represents local state of search screen
class SearchScreenBloc {
  final Store store;

  /// controller for suggestions
  final BehaviorSubject<List<SearchSuggestion>> _suggestions =
      BehaviorSubject<List<SearchSuggestion>>();

  /// Sink for searchText
  final PublishSubject<String> _searchText = PublishSubject<String>();

  /// Store subscriptions
  StreamSubscription<dynamic> _storeSubscription;

  SearchScreenBloc({@required this.store}) {
    _handleSearchTextChanges();
  }

  void _handleSearchTextChanges() {
    _storeSubscription = _searchText.stream
        .where((text) => text.isNotEmpty)
        .debounceTime(Duration(milliseconds: 300))
        .flatMap((text) => Stream.fromFuture(store.search.getSuggestions(text)))
        .throttleTime(Duration(milliseconds: 100))
        .listen(_suggestions.add);
  }

  // Stream of search suggestions
  Stream<List<SearchSuggestion>> get suggestions => _suggestions.stream;

  // Sink for changes to search text
  void Function(String) get changeSearchText => _searchText.add;

  Future<void> dispose() async {
    await _storeSubscription.cancel();
    await _suggestions.close();
    await _searchText.close();
  }
}
