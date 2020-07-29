// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import 'package:phenopod/blocs/user_bloc.dart';
import 'package:phenopod/screens/sign_in_screen.dart';
import 'package:phenopod/screens/splash_screen.dart';
import 'package:phenopod/utils/utils.dart';
import 'app_screen.dart';

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ///! Calculate and cache screen height as close to the root of widget tree
    ///! as possible, For some reason top padding returns 0 if you do otherwise
    getScreenHeight(context: context);
    getScreenWidth(context: context);

    return StreamBuilder<bool>(
      stream: Provider.of<UserBloc>(context).userSignedIn,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SplashScreen();
        }
        return snapshot.data ? AppScreen() : SignInScreen();
      },
    );
  }
}
