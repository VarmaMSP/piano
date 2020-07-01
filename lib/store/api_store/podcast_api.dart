import 'package:phenopod/model/main.dart';
import 'package:phenopod/service/http_client.dart';
import 'package:phenopod/store/store.dart';

class PodcastApi extends PodcastStore {
  final HttpClient httpClient;

  PodcastApi(this.httpClient);

  @override
  Future<Podcast> get_(String podcastUrlParam) async {
    final apiResponse = await httpClient.makeRequest(
      method: 'GET',
      path: '/podcasts/$podcastUrlParam',
    );
    return apiResponse.podcasts[0]?.copyWith(
      episodes: apiResponse.episodes,
      moreEpisodes: apiResponse.episodes.length < 15,
    );
  }

  @override
  Stream<Podcast> watch(String podcastUrlParam) async* {
    throw UnimplementedError();
  }

  @override
  Future<void> cache(String _urlParam) {
    throw UnimplementedError();
  }

  @override
  Future<bool> isCached({String id, String urlParam}) {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteCache({String id, String urlParam}) {
    throw UnimplementedError();
  }
}
