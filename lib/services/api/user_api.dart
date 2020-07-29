// Flutter imports:
import 'package:flutter/foundation.dart';

// Project imports:
import 'package:phenopod/models/main.dart';
import 'http_client.dart';

UserApi newUserApi(HttpClient httpClient) {
  return _UserApiImpl(httpClient);
}

abstract class UserApi {
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

class _UserApiImpl extends UserApi {
  final HttpClient httpClient;

  _UserApiImpl(this.httpClient);

  @override
  Future<User> getSignedInUser() async {
    final apiResponse = await httpClient.makeRequest(
      method: 'POST',
      path: '/ajax/service',
      queryParams: {'endpoint': 'load_session'},
    );
    return apiResponse.users.isEmpty ? null : apiResponse.users[0];
  }

  @override
  Future<void> signInWithFacebook({
    String accessToken,
    GuestCredentials guestCredentials,
  }) async {
    await httpClient.makeRequest(
      method: 'POST',
      path: '/mobile/signin/facebook',
      body: {
        'facebook_access_token': accessToken,
        if (guestCredentials != null)
          'guest_account': guestCredentials.toJson(),
      },
    );
  }

  @override
  Future<void> signInWithGoogle({
    String idToken,
    GuestCredentials guestCredentials,
  }) async {
    await httpClient.makeRequest(
      method: 'POST',
      path: '/mobile/signin/google',
      body: {
        'google_id_token': idToken,
        if (guestCredentials != null)
          'guest_account': guestCredentials.toJson(),
      },
    );
  }

  @override
  Future<void> signInWithGuest(GuestCredentials credentials) async {
    await httpClient.makeRequest(
      method: 'POST',
      path: '/mobile/signin/guest',
      body: {'guest_account': credentials.toJson()},
    );
  }
}
