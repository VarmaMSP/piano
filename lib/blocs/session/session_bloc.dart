import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:phenopod/models/main.dart';
import 'package:phenopod/repositories/session_service.dart';

part 'session_event.dart';
part 'session_state.dart';

class SessionBloc extends Bloc<SessionEvent, SessionState> {
  final SessionService _sessionService = SessionService();

  @override
  SessionState get initialState => SessionUninitialized();

  @override
  Stream<SessionState> mapEventToState(
    SessionEvent event,
  ) async* {
    if (event is AppStarted || event is SignedIn) {
      final user = await _sessionService.loadSession();

      if (user != null) {
        yield SessionAuthenticated(user);
      } else {
        yield SessionUnauthenticated();
      }
    }

    if (event is SignedOut) {
      yield SessionUnauthenticated();
    }
  }
}
