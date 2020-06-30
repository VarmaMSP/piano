import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class SocialSignIn {
  Future<String> getGoogleIdToken() async {
    final googleSignIn = GoogleSignIn(scopes: ['profile', 'email']);
    final account = await googleSignIn.signIn();
    final authentication = await account.authentication;
    return authentication.idToken;
  }

  // ignore: missing_return
  Future<String> getFacebookAccessToken() async {
    final facebookLogin = FacebookLogin();
    final result = await facebookLogin.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        return result.accessToken.token;
      case FacebookLoginStatus.cancelledByUser:
        return null;
      case FacebookLoginStatus.error:
        return null;
    }
  }
}
