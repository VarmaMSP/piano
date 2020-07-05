import 'package:path_provider/path_provider.dart';

import 'episode_api.dart';
import 'user_api.dart';
import 'podcast_api.dart';
import 'http_client.dart';

/// Because you cannot use platform channels in background isolate
/// you need to pass appDocDirPath if this method is being called from
/// a background isolate
Future<Api> newApi({String appDocDirPath}) async {
  appDocDirPath ??= (await getApplicationDocumentsDirectory()).path;
  return _ApiImpl(HttpClient(appDocDirPath: appDocDirPath));
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
