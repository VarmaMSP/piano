import 'dart:async';

import 'package:phenopod/service/http_client.dart';
import 'package:phenopod/model/user.dart';
import 'package:phenopod/store/store.dart';

class UserApi extends UserStore {
  final HttpClient httpClient;

  UserApi(this.httpClient);

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
  Future<void> signInWithGuest(GuestCredentials credentials) async {
    await httpClient.makeRequest(
      method: 'POST',
      path: '/mobile/signin/guest',
      body: {'guest_account': credentials.toJson()},
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
}
