import 'package:flutter/foundation.dart';
import 'package:phenopod/service/api/api.dart';
import 'package:phenopod/model/main.dart';
import 'package:phenopod/service/sqldb/sqldb.dart';

UserStore newUserStore(Api api, Db db) {
  return _UserStoreImpl(api: api, db: db);
}

abstract class UserStore {
  Future<User> getSignedInUser();
  Future<void> signInWithGuest(GuestCredentials credentials);
  Future<void> signInWithGoogle({
    @required String idToken,
    GuestCredentials guestCredentials,
  });
  Future<void> signInWithFacebook({
    @required String accessToken,
    GuestCredentials guestCredentials,
  });
}

class _UserStoreImpl extends UserStore {
  final Api api;
  final Db db;

  _UserStoreImpl({
    @required this.api,
    @required this.db,
  });

  @override
  Future<User> getSignedInUser() {
    return api.user.getSignedInUser();
  }

  @override
  Future<void> signInWithFacebook({
    String accessToken,
    GuestCredentials guestCredentials,
  }) {
    return api.user.signInWithFacebook(
        accessToken: accessToken, guestCredentials: guestCredentials);
  }

  @override
  Future<void> signInWithGoogle({
    String idToken,
    GuestCredentials guestCredentials,
  }) {
    return api.user
        .signInWithGoogle(idToken: idToken, guestCredentials: guestCredentials);
  }

  @override
  Future<void> signInWithGuest(GuestCredentials credentials) {
    return api.user.signInWithGuest(credentials);
  }
}
