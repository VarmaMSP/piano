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
      path: '/ajax/service?endpoint=load_session',
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
  Future<void> signInWithFacebook({String accessToken, String guestId}) async {}

  @override
  Future<void> signInWithGoogle({String idToken, String guestId}) async {}
}

/// A uuid generated on the device is used either sign in or create a new account
/// Generated id is stored in secure storage and is deleted when user links
/// guest account to a social account
// class GuestCredentials {
//   static const String guestIdStorageKey = 'GUEST_ID_STORAGE_KEY';

//   String _id;
//   String _deviceUuid;
//   String _deviceOs;
//   String _deviceModel;

//   Future<void> load() async {
//     final androidInfo = await DeviceInfoPlugin().androidInfo;

//     _id = await _getId() ?? await _newId();
//     _deviceOs = androidInfo.version.baseOS;
//     _deviceModel = androidInfo.model;
//   }

//   Future<void> delete() {
//     final storage = FlutterSecureStorage();
//     return storage.delete(key: guestIdStorageKey);
//   }

//   Map<String, dynamic> toJson() {
//     return <String, dynamic>{
//       'id': _id,
//       'device_uuid': _deviceUuid ?? '',
//       'device_os': _deviceOs,
//       'device_model': _deviceModel,
//     };
//   }

//   Future<String> _getId() {
//     final storage = FlutterSecureStorage();
//     return storage.read(key: guestIdStorageKey);
//   }

//   Future<String> _newId() async {
//     final newId = Uuid().v4();
//     await _saveId(newId);
//     return newId;
//   }

//   Future<void> _saveId(String guestId) {
//     final storage = FlutterSecureStorage();
//     return storage.write(key: guestIdStorageKey, value: guestId);
//   }
// }
