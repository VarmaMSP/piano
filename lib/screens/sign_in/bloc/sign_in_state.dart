part of 'sign_in_bloc.dart';

abstract class SignInState extends Equatable {
  const SignInState();

  @override
  List<Object> get props => [];
}

class SignInInitial extends SignInState {}

class SignInInProgress extends SignInState {}

class SignInComplete extends SignInState {}
