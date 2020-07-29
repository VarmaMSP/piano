// Package imports:
import 'package:device_info/device_info.dart';
import 'package:rxdart/rxdart.dart';

// Project imports:
import 'package:phenopod/models/main.dart';
import 'package:phenopod/services/keychain.dart';
import 'package:phenopod/services/social_sign_in.dart';
import 'package:phenopod/store/store.dart';

class UserBloc {
  final Store store;

  // Controller for current signed in user
  final BehaviorSubject<User> _user = BehaviorSubject<User>();

  // Stream for users's sign in status
  final BehaviorSubject<bool> _userSignedIn = BehaviorSubject<bool>();

  // Stream for flagging that user is signing in
  final BehaviorSubject<bool> _userSigningIn = BehaviorSubject<bool>();

  UserBloc(this.store) {
    // handle sign in / out transitions
    _handleSignInTransitions();

    // load user when bloc is initialized
    _loadUser();
  }

  void _handleSignInTransitions() {
    _user.stream.listen((user) {
      print('user: $user');
      _userSignedIn.add(user != null);
      _userSigningIn.add(false);
    });
  }

  // Loads user details from server
  Future<void> _loadUser() async {
    _user.add(await store.user.getSignedInUser());
  }

  Future<void> signInWithGuest() async {
    _userSigningIn.add(true);

    final keychain = Keychain();
    final androidInfo = await DeviceInfoPlugin().androidInfo;
    final guestCredentials = await keychain.getGuestCredentials() ??
        GuestCredentials.fromAndroidDeviceInfo(androidInfo);

    await store.user.signInWithGuest(guestCredentials);
    await keychain.saveGuestCredentials(guestCredentials);
    await _loadUser();
  }

  Future<void> signInWithGoogle() async {
    _userSigningIn.add(true);

    final keychain = Keychain();
    final socialSignIn = SocialSignIn();
    final guestCredentials = await keychain.getGuestCredentials();
    final googleIdToken = await socialSignIn.getGoogleIdToken();

    await store.user.signInWithGoogle(
      idToken: googleIdToken,
      guestCredentials: guestCredentials,
    );
    await keychain.deleteGuestCredentials();
    await _loadUser();
  }

  Future<void> signInWithFacebook() async {
    _userSigningIn.add(true);

    final keychain = Keychain();
    final socialSignIn = SocialSignIn();
    final guestCredentials = await keychain.getGuestCredentials();
    final facebookAccessToken = await socialSignIn.getFacebookAccessToken();

    await store.user.signInWithFacebook(
      accessToken: facebookAccessToken,
      guestCredentials: guestCredentials,
    );
    await keychain.deleteGuestCredentials();
    await _loadUser();
  }

  // Sign out user
  void Function() get signOut => () => _user.add(null);

  // Get if user is signed in
  Stream<bool> get userSignedIn => _userSignedIn.stream;

  // Get if user is currently signing in
  Stream<bool> get userSigningIn => _userSigningIn.stream;

  Future<void> dispose() async {
    await _user.close();
    await _userSignedIn.close();
    await _userSigningIn.close();
  }
}
