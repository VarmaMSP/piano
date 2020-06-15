import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:phenopod/app/main.dart';
import 'package:phenopod/bloc/podcast_actions_bloc.dart';
import 'package:phenopod/bloc/user_bloc.dart';
import 'package:phenopod/screens/sign_in/main.dart';
import 'package:phenopod/screens/splash.dart';
import 'package:provider/provider.dart';
import 'package:phenopod/bloc/audio_player.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();

  runApp(Root());
}

class Root extends StatefulWidget {
  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> with WidgetsBindingObserver {
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

    return MultiProvider(
      providers: [
        Provider<AudioPlayerBloc>(
          create: (_) => AudioPlayerBloc(),
          dispose: (_, value) => value.dispose(),
        ),
        Provider<UserBloc>(
          create: (_) => UserBloc(),
          dispose: (_, value) => value.dispose(),
        ),
        Provider<PodcastActionsBloc>(
          create: (_) => PodcastActionsBloc(),
          dispose: (_, value) => value.dispose(),
        ),
      ],
      child: Builder(builder: (context) {
        return MaterialApp(
          title: 'Phenopod',
          debugShowCheckedModeBanner: false,
          home: StreamBuilder<bool>(
            stream: Provider.of<UserBloc>(context).userSignedIn,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return SplashScreen();
              }
              return snapshot.data ? App() : SignInScreen();
            },
          ),
        );
      }),
    );
  }
}

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onTransition(
    Bloc<dynamic, dynamic> bloc,
    Transition<dynamic, dynamic> transition,
  ) {
    print(transition);
    super.onTransition(bloc, transition);
  }

  @override
  void onError(
    Bloc<dynamic, dynamic> bloc,
    Object error,
    StackTrace stackTrace,
  ) {
    print(error);
    super.onError(bloc, error, stackTrace);
  }
}
