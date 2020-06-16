import 'package:phenopod/model/main.dart';
import 'package:phenopod/store/store.dart';

import 'utils.dart';

class EpisodeApi extends EpisodeStore {
  @override
  Future<List<Episode>> getByPodcastPaginated(
    String podcastId,
    int offset,
    int limit,
  ) async {
    final apiResponse = await makeRequest(
      method: 'GET',
      path: '/ajax/browse',
      queryParams: <String, String>{
        'endpoint': 'podcast_episodes',
        'podcast_id': podcastId,
        'offset': offset.toString(),
        'limit': limit.toString(),
        'order': 'pub_date_desc',
      },
    );

    return apiResponse.episodes;
  }
}
