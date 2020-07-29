// Package imports:
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SocialSignIn {
  Future<String> getGoogleIdToken() async {
    final googleSignIn = GoogleSignIn(scopes: ['profile', 'email']);
    final account = await googleSignIn.signIn();
    final authentication = await account.authentication;
    return authentication.idToken;
  }

  Future<bool> isAuthenticatedByGoogle() {
    final googleSignIn = GoogleSignIn();
    return googleSignIn.isSignedIn();
  }

  Future<void> signOutGoogle() async {
    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
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

  Future<bool> isAuthenticatedByFacebook() {
    final facebookLogin = FacebookLogin();
    return facebookLogin.isLoggedIn;
  }

  Future<void> signOutFacebook() async {
    final facebookLogin = FacebookLogin();
    await facebookLogin.logOut();
  }
}
