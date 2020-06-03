import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phenopod/blocs/session/session_bloc.dart';
import 'package:phenopod/screens/sign_in/bloc/sign_in_bloc.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final signInBloc = SignInBloc();

    return BlocConsumer<SignInBloc, SignInState>(
      bloc: signInBloc,
      listenWhen: (prev, current) {
        return current is SignInComplete;
      },
      listener: (context, state) {
        if (state is SignInComplete) {
          BlocProvider.of<SessionBloc>(context).add(AppStarted());
        }
      },
      builder: (context, state) {
        if (state is SignInInitial) {
          return Scaffold(
            body: Container(
              child: Center(
                child: FlatButton(
                  onPressed: () {
                    signInBloc.add(SignInWithGuest());
                  },
                  child: Text('Please Sign up my app'),
                ),
              ),
            ),
          );
        }

        return Scaffold(
          body: Container(
            child: Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }
}
