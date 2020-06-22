import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:phenopod/app/app.dart';
import 'package:phenopod/bloc/app_navigation_bloc.dart';
import 'package:phenopod/screen/queue_screen/queue_screen.dart';
import 'package:phenopod/screen/search_screen/search_screen.dart';
import 'package:phenopod/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:phenopod/bloc/audio_player_bloc.dart';
import 'package:phenopod/bloc/podcast_actions_bloc.dart';
import 'package:phenopod/bloc/user_bloc.dart';
import 'package:phenopod/service/audio_service/audio_service.dart';
import 'package:phenopod/service/http_client/http_client.dart';
import 'package:phenopod/service/sqldb/sqldb.dart';
import 'package:phenopod/store/store.dart';
import 'package:phenopod/store/store_impl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final sqlDb = await newSqlDb();
  final httpClient = await newHttpClient();
  final audioService = newAudioService();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(Root(
    sqlDb: sqlDb,
    httpClient: httpClient,
    audioService: audioService,
  ));
}

class Root extends StatefulWidget {
  Root({
    @required this.sqlDb,
    @required this.httpClient,
    @required this.audioService,
  });

  final SqlDb sqlDb;
  final HttpClient httpClient;
  final AudioService audioService;

  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> with WidgetsBindingObserver {
  Store _store;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    widget.audioService.connect();
    _store = newStore(widget.sqlDb, widget.httpClient);
  }

  @override
  void dispose() {
    widget.audioService.disconnect();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        widget.audioService.connect();
        break;
      case AppLifecycleState.paused:
        widget.audioService.disconnect();
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
        Provider<SqlDb>(
          create: (_) => widget.sqlDb,
        ),
        Provider<Store>(
          create: (_) => _store,
        ),
        Provider<AppNavigationBloc>(
          create: (_) => AppNavigationBloc(),
          dispose: (_, value) => value.dispose(),
        ),
        Provider<AudioPlayerBloc>(
          create: (_) => AudioPlayerBloc(_store, widget.audioService),
          dispose: (_, value) => value.dispose(),
        ),
        Provider<UserBloc>(
          create: (_) => UserBloc(_store),
          dispose: (_, value) => value.dispose(),
        ),
        Provider<PodcastActionsBloc>(
          create: (_) => PodcastActionsBloc(_store),
          dispose: (_, value) => value.dispose(),
        ),
      ],
      child: Builder(builder: (context) {
        return MaterialApp(
          title: 'Phenopod',
          debugShowCheckedModeBanner: false,
          initialRoute: '/app',
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case '/app':
                return MaterialPageRoute(
                  builder: (context) => App(
                    height: getScreenHeight(context),
                  ),
                );
              case '/queue':
                return PageTransition(
                  child: QueueScreen(),
                  type: PageTransitionType.downToUp,
                  duration: Duration(milliseconds: 150),
                  curve: Curves.easeIn,
                );
              case '/search':
                return PageTransition(
                  child: SearchScreen(),
                  type: PageTransitionType.downToUp,
                  duration: Duration(milliseconds: 150),
                  curve: Curves.easeIn,
                );
              default:
                return null;
            }
          },
        );
      }),
    );
  }
}
