import 'package:phenopod/service/http_client.dart';

import 'episode_api.dart';
import 'user_api.dart';
import 'podcast_api.dart';

Api newApi(HttpClient httpClient) {
  return _ApiImpl(httpClient);
}

abstract class Api {
  UserApi get user;
  PodcastApi get podcast;
  EpisodeApi get episode;
}

class _ApiImpl extends Api {
  final PodcastApi _podcastApi;
  final EpisodeApi _episodeApi;
  final UserApi _userApi;

  _ApiImpl(HttpClient httpClient)
      : _podcastApi = newPodcastApi(httpClient),
        _episodeApi = newEpisodeApi(httpClient),
        _userApi = newUserApi(httpClient);

  @override
  PodcastApi get podcast => _podcastApi;

  @override
  EpisodeApi get episode => _episodeApi;

  @override
  UserApi get user => _userApi;
}
