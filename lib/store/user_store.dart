// Flutter imports:
import 'package:flutter/foundation.dart';

// Project imports:
import 'package:phenopod/models/main.dart';
import 'package:phenopod/services/alarm_service/alarm_service.dart';
import 'package:phenopod/services/api/api.dart';
import 'package:phenopod/services/db/db.dart';

UserStore newUserStore(
  Api api,
  Db db,
  AlarmService alarmService,
  bool lazyQueries,
) {
  return _UserStoreImpl(api: api, db: db, alarmService: alarmService);
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
  final AlarmService alarmService;

  _UserStoreImpl({
    @required this.api,
    @required this.db,
    @required this.alarmService,
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
      accessToken: accessToken,
      guestCredentials: guestCredentials,
    );
  }

  @override
  Future<void> signInWithGoogle({
    String idToken,
    GuestCredentials guestCredentials,
  }) {
    return api.user.signInWithGoogle(
      idToken: idToken,
      guestCredentials: guestCredentials,
    );
  }

  @override
  Future<void> signInWithGuest(GuestCredentials credentials) {
    return api.user.signInWithGuest(credentials);
  }
}
