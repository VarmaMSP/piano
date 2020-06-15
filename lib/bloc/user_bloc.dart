import 'package:phenopod/models/main.dart';
import 'package:phenopod/repositories/session_service.dart';
import 'package:rxdart/rxdart.dart';

class UserBloc {
  final SessionService _sessionService = SessionService();

  // Controller for current signed in user
  final BehaviorSubject<User> _user = BehaviorSubject<User>();

  // Stream for users's sign in status
  final BehaviorSubject<bool> _userSignedIn = BehaviorSubject<bool>();

  // Stream for flagging that the user is signing in
  final BehaviorSubject<bool> _userSigningIn = BehaviorSubject<bool>();

  UserBloc() {
    // handle sign in / out transistions
    _handleSignInTransistions();

    // load user, first time when app is initialized
    _loadUser();
  }

  void _handleSignInTransistions() {
    _user.stream.distinct().listen((user) {
      _userSignedIn.add(user != null);
      _userSigningIn.add(false);
    });
  }

  // Sign in user with guest accountt
  Future<void> signInWithGuest() async {
    _userSignedIn.add(true);
    await _sessionService.signInWithGuest();
    await _loadUser();
  }

  // Loads user details from server
  Future<void> _loadUser() async {
    _user.add(await _sessionService.loadSession());
  }

  // Sign out user
  void Function() get signOut => () => _user.add(null);

  // get if user is signed in
  Stream<bool> get userSignedIn => _userSignedIn.stream;

  // get if user is currently signing in
  Stream<bool> get userSigningIn => _userSigningIn.stream;

  Future<void> dispose() async {
    await _user.close();
    await _userSignedIn.close();
    await _userSigningIn.close();
  }
}
