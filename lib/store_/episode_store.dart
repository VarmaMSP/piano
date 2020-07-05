import 'package:flutter/foundation.dart';
import 'package:phenopod/service/api/api.dart';
import 'package:phenopod/model/episode.dart';
import 'package:phenopod/service/sqldb/sqldb.dart';

EpisodeStore newEpisodeStore(Api api, Db_ db) {
  return _EpisodeStoreImpl(api: api, db: db);
}

abstract class EpisodeStore {
  Future<void> saveAll(List<Episode> episodes);
  Future<List<Episode>> getByPodcastPaginated({
    @required String podcastId,
    @required int offset,
    @required int limit,
  });
  Stream<List<Episode>> watchByPodcast(String podcastId);
  Future<List<Episode>> getFromSubscriptionsPaginated(int offset, int limit);
}

class _EpisodeStoreImpl extends EpisodeStore {
  final Api api;
  final Db_ db;

  _EpisodeStoreImpl({
    @required this.api,
    @required this.db,
  });

  @override
  Future<List<Episode>> getByPodcastPaginated(
      {String podcastId, int offset, int limit}) {
    // TODO: implement getByPodcastPaginated
    throw UnimplementedError();
  }

  @override
  Future<List<Episode>> getFromSubscriptionsPaginated(int offset, int limit) {
    // TODO: implement getFromSubscriptionsPaginated
    throw UnimplementedError();
  }

  @override
  Future<void> saveAll(List<Episode> episodes) {
    // TODO: implement saveAll
    throw UnimplementedError();
  }

  @override
  Stream<List<Episode>> watchByPodcast(String podcastId) {
    // TODO: implement watchByPodcast
    throw UnimplementedError();
  }
}
