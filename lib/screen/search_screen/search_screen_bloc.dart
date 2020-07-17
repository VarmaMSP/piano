// Package imports:
import 'package:rxdart/rxdart.dart';

// Project imports:
import 'package:phenopod/model/main.dart';
import 'package:phenopod/utils/request.dart';

// This Bloc represents local state of search screen
class SearchScreenBloc {
  /// controller for suggestions
  final BehaviorSubject<List<SearchSuggestion>> _suggestions =
      BehaviorSubject<List<SearchSuggestion>>();

  /// Sink for searchText
  final PublishSubject<String> _searchText = PublishSubject<String>();

  /// Indicates if thisblocis disposed
  bool _isDisposed = false;

  SearchScreenBloc() {
    _handleSearchTextChanges();
  }

  void _handleSearchTextChanges() {
    _searchText.stream
        .where((text) => text.isNotEmpty)
        .debounceTime(Duration(milliseconds: 300))
        .listen(
      (text) async {
        final response = await makeRequest(
          method: 'GET',
          path: '/suggest',
          queryParams: {'query': text},
        );

        if (!_isDisposed) {
          _suggestions.add(response.searchSuggestions);
        }
      },
    );
  }

  // Stream of search suggestions
  Stream<List<SearchSuggestion>> get suggestions => _suggestions.stream;

  // Sink for changes to search text
  void Function(String) get changeSearchText => _searchText.add;

  Future<void> dispose() async {
    await _suggestions.close();
    await _searchText.close();
    _isDisposed = true;
  }
}
