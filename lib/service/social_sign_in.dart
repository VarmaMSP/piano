import 'package:google_sign_in/google_sign_in.dart';

class SocialSignIn {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['profile', 'email']);

  Future<String> getGoogleIdToken() async {
    final account = await _googleSignIn.signIn();
    final authentication = await account.authentication;
    return authentication.idToken;
  }

  Future<String> getFacebookAccessToken() async {
    return '';
  }
}
