// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:phenopod/blocs/user_bloc.dart';
import 'package:phenopod/utils/chrome.dart' as chromeutils;

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userBloc = Provider.of<UserBloc>(context);

    chromeutils.applySystemUIOverlayStyle();

    return StreamBuilder<bool>(
      stream: userBloc.userSigningIn,
      builder: (context, snapshot) {
        if (!snapshot.hasData || !snapshot.data) {
          return Scaffold(
            backgroundColor: Colors.white,
            resizeToAvoidBottomInset: false,
            appBar: PreferredSize(
              preferredSize: const Size(0, 0),
              child: Container(),
            ),
            body: Container(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  SignInButton(
                    Buttons.GoogleDark,
                    text: 'Sign in with Google',
                    onPressed: userBloc.signInWithGoogle,
                  ),
                  Container(height: 20),
                  SignInButton(
                    Buttons.Facebook,
                    text: 'Sign in with Facebook',
                    onPressed: userBloc.signInWithFacebook,
                  ),
                  Container(height: 15),
                  Text('or'),
                  Container(height: 15),
                  FlatButton(
                    onPressed: userBloc.signInWithGuest,
                    child: Text(
                      'Sign in as guest',
                      style: TextStyle(
                        fontSize: 15,
                        letterSpacing: 0.15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Container(height: 30),
                ],
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
