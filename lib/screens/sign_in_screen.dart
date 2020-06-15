import 'package:flutter/material.dart';
import 'package:phenopod/bloc/user_bloc.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userBloc = Provider.of<UserBloc>(context);

    return StreamBuilder<bool>(
      stream: userBloc.userSigningIn,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            body: Container(
              child: Center(
                child: FlatButton(
                  onPressed: userBloc.signInWithGuest,
                  child: Text('Please Sign up my app'),
                ),
              ),
            ),
          );
        }

        /// Once userSigningIn is set to false, this page should
        /// be replaced, So show loading indicator regardless of
        /// useSigingIn value
        return Scaffold(
          body: Container(
            child: Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }
}
