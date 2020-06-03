part of 'session_bloc.dart';

abstract class SessionState extends Equatable {
  const SessionState();

  @override
  List<Object> get props => [];
}

class SessionUninitialized extends SessionState {}

class SessionAuthenticated extends SessionState {
  SessionAuthenticated(this.user);

  final User user;

  @override
  List<Object> get props => [user];
}

class SessionUnauthenticated extends SessionState {}
