part of 'session_bloc.dart';

abstract class SessionEvent extends Equatable {
  const SessionEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends SessionEvent {}

class SignedIn extends SessionEvent {
  SignedIn(this.user);

  final User user;

  @override
  List<Object> get props => [];
}

class SignedOut extends SessionEvent {}
