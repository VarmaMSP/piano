// Project imports:
import 'package:phenopod/models/main.dart';
import 'http_client.dart';

SearchApi newSearchApi(HttpClient httpClient) {
  return _SearchApiImpl(httpClient);
}

abstract class SearchApi {
  Future<List<SearchSuggestion>> getSuggestions(String searchText);
}

class _SearchApiImpl extends SearchApi {
  final HttpClient httpClient;

  _SearchApiImpl(this.httpClient);

  @override
  Future<List<SearchSuggestion>> getSuggestions(String searchText) async {
    final apiResponse = await httpClient.makeRequest(
      method: 'GET',
      path: '/suggest',
      queryParams: {'query': searchText},
    );
    return apiResponse.searchSuggestions;
  }
}
