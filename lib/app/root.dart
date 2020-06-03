import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phenopod/app/sign_up.dart';
import 'package:phenopod/app/splash.dart';
import 'package:phenopod/blocs/audio_player/audio_player_bloc.dart';
import 'package:phenopod/blocs/session/session_bloc.dart';

import 'content.dart';

class AppRoot extends StatefulWidget {
  @override
  _AppRootState createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    AudioService.connect();
  }

  @override
  void dispose() {
    AudioService.disconnect();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        AudioService.connect();
        break;
      case AppLifecycleState.paused:
        AudioService.disconnect();
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    return MultiBlocProvider(
      providers: <BlocProvider<dynamic>>[
        BlocProvider<SessionBloc>(
          create: (BuildContext context) => SessionBloc()..add(AppStarted()),
        ),
        BlocProvider<AudioPlayerBloc>(
          create: (BuildContext context) => AudioPlayerBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Phenopod',
        debugShowCheckedModeBanner: false,
        home: BlocBuilder<SessionBloc, SessionState>(
          builder: (context, state) {
            if (state is SessionLoading) {
              return AppSplash();
            }
            if (state is SessionUnauthenticated) {
              return AppSignUp();
            }
            if (state is SessionAuthenticated) {
              return AppContent();
            }
            return AppSplash();
          },
        ),
      ),
    );
  }
}
