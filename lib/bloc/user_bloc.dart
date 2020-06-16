import 'package:phenopod/model/main.dart';
import 'package:phenopod/store/store.dart';
import 'package:rxdart/rxdart.dart';

class UserBloc {
  final Store store;

  // Controller for current signed in user
  final BehaviorSubject<User> _user = BehaviorSubject<User>();

  // Stream for users's sign in status
  final BehaviorSubject<bool> _userSignedIn = BehaviorSubject<bool>();

  // Stream for flagging that user is signing in
  final BehaviorSubject<bool> _userSigningIn = BehaviorSubject<bool>();

  UserBloc(this.store) {
    // handle sign in / out transistions
    _handleSignInTransistions();

    // load user when bloc is initialized
    _loadUser();
  }

  void _handleSignInTransistions() {
    _user.stream.distinct().listen((user) {
      _userSignedIn.add(user != null);
      _userSigningIn.add(false);
    });
  }

  // Loads user details from server
  Future<void> _loadUser() async {
    _user.add(await store.user.getSignedInUser());
  }

  // Sign in user with guest account
  Future<void> signInWithGuest() async {
    _userSigningIn.add(true);
    await store.user.signInWithGuest();
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
