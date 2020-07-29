// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Project imports:
import 'package:phenopod/models/main.dart';

class Keychain {
  static const String guestCredentialsStorageKey =
      'GUEST_CREDENTIALS_STORAGE_KEY';

  final storage = FlutterSecureStorage();

  Future<GuestCredentials> getGuestCredentials() async {
    final value = await storage.read(key: guestCredentialsStorageKey);
    return value != null
        ? GuestCredentials.fromJson(json.decode(value) as Map<String, dynamic>)
        : null;
  }

  Future<void> saveGuestCredentials(GuestCredentials credentials) async {
    await storage.write(
      key: guestCredentialsStorageKey,
      value: json.encode(credentials.toJson()),
    );
  }

  Future<void> deleteGuestCredentials() async {
    await storage.delete(key: guestCredentialsStorageKey);
  }
}
