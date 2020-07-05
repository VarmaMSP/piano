import 'package:flutter/foundation.dart';
import 'package:phenopod/service/api/api.dart';
import 'package:phenopod/model/main.dart';
import 'package:phenopod/service/sqldb/sqldb.dart';

PodcastStore newPodcastStore(Api api, Db_ db) {
  return _PodcastStoreImpl(api: api, db: db);
}

abstract class PodcastStore {
  Future<Podcast> get_(String urlParam);
  Stream<Podcast> watch(String urlParam);
  Stream<Podcast> watch_(String urlParam);
  Future<void> refresh(String urlParam);
  Future<void> cache(String _urlParam);
  Future<bool> isCached({String id, String urlParam});
  Future<void> deleteCache({String id, String urlParam});
}

class _PodcastStoreImpl extends PodcastStore {
  final Api api;
  final Db_ db;

  _PodcastStoreImpl({
    @required this.api,
    @required this.db,
  });

  @override
  Future<void> cache(String _urlParam) {
    // TODO: implement cache
    throw UnimplementedError();
  }

  @override
  Future<void> deleteCache({String id, String urlParam}) {
    // TODO: implement deleteCache
    throw UnimplementedError();
  }

  @override
  Future<Podcast> get_(String urlParam) {
    // TODO: implement get_
    throw UnimplementedError();
  }

  @override
  Future<bool> isCached({String id, String urlParam}) {
    // TODO: implement isCached
    throw UnimplementedError();
  }

  @override
  Future<void> refresh(String urlParam) {
    // TODO: implement refresh
    throw UnimplementedError();
  }

  @override
  Stream<Podcast> watch(String urlParam) {
    // TODO: implement watch
    throw UnimplementedError();
  }

  @override
  Stream<Podcast> watch_(String urlParam) {
    // TODO: implement watch_
    throw UnimplementedError();
  }
}
