// Package imports:
import 'package:path_provider/path_provider.dart';

// Project imports:
import 'package:phenopod/services/api/search_api.dart';
import 'episode_api.dart';
import 'http_client.dart';
import 'podcast_api.dart';
import 'subscription_api.dart';
import 'user_api.dart';

/// Because you cannot use platform channels in an isolate you need to
/// pass appDocDirPath if this method is being called from a an isolate
Future<Api> newApi({String appDocDirPath}) async {
  appDocDirPath ??= (await getApplicationDocumentsDirectory()).path;
  return _ApiImpl(HttpClient(appDocDirPath: appDocDirPath));
}

abstract class Api {
  UserApi get user;
  PodcastApi get podcast;
  EpisodeApi get episode;
  SubscriptionApi get subscription;
  SearchApi get search;
}

class _ApiImpl extends Api {
  final PodcastApi _podcastApi;
  final EpisodeApi _episodeApi;
  final UserApi _userApi;
  final SubscriptionApi _subscriptionApi;
  final SearchApi _searchApi;

  _ApiImpl(HttpClient httpClient)
      : _podcastApi = newPodcastApi(httpClient),
        _episodeApi = newEpisodeApi(httpClient),
        _userApi = newUserApi(httpClient),
        _subscriptionApi = newSubscriptionApi(httpClient),
        _searchApi = newSearchApi(httpClient);

  @override
  PodcastApi get podcast => _podcastApi;

  @override
  EpisodeApi get episode => _episodeApi;

  @override
  UserApi get user => _userApi;

  @override
  SubscriptionApi get subscription => _subscriptionApi;

  @override
  SearchApi get search => _searchApi;
}
