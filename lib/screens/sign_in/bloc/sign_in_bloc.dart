import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:phenopod/repositories/session_service.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final SessionService _sessionService = SessionService();

  @override
  SignInState get initialState => SignInInitial();

  @override
  Stream<SignInState> mapEventToState(
    SignInEvent event,
  ) async* {
    if (event is SignInWithGuest) {
      yield SignInInProgress();
      try {
        await _sessionService.signInWithGuest();
        yield SignInComplete();
      } catch (err) {
        log(err.toString());
      }
    }
  }
}
