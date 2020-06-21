import 'package:flutter/material.dart';
import 'package:phenopod/bloc/user_bloc.dart';
import 'package:phenopod/screen/sign_in_screen.dart';
import 'package:phenopod/screen/splash_screen.dart';
import 'package:provider/provider.dart';

import 'app.dart';

class AppScreen extends StatelessWidget {
  const AppScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: Provider.of<UserBloc>(context).userSignedIn,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SplashScreen();
        }
        return snapshot.data ? App() : SignInScreen();
      },
    );
  }
}
