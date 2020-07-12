import 'package:flutter/material.dart';
import 'package:phenopod/bloc/user_bloc.dart';
import 'package:phenopod/screen/sign_in_screen.dart';
import 'package:phenopod/screen/splash_screen.dart';
import 'package:phenopod/utils/utils.dart';
import 'package:provider/provider.dart';

import 'app_screen.dart';

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ///! Get screen height as early as possible,
    ///! for some reason top padding returns 0 if you do otherwise
    final screenHeight = getScreenHeight(context);

    return StreamBuilder<bool>(
      stream: Provider.of<UserBloc>(context).userSignedIn,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SplashScreen();
        }
        return snapshot.data
            ? AppScreen(screenHeight: screenHeight)
            : SignInScreen();
      },
    );
  }
}
