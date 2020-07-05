import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phenopod/app/app.dart';
import 'package:phenopod/screen/queue_screen/queue_screen.dart';
import 'package:phenopod/screen/search_screen/search_screen.dart';
import 'package:phenopod/service/api/api.dart';
// import 'package:phenopod/task_runner/task_runner.dart';
import 'package:phenopod/theme/theme.dart';
import 'package:provider/provider.dart';
import 'package:phenopod/bloc/audio_player_bloc.dart';
import 'package:phenopod/bloc/podcast_actions_bloc.dart';
import 'package:phenopod/bloc/user_bloc.dart';
import 'package:phenopod/bloc/app_navigation_bloc.dart';
import 'package:phenopod/service/audio_service/audio_service.dart';
import 'package:phenopod/service/sqldb/sqldb.dart';
import 'package:phenopod/store/store.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final api = await newApi();
  final db = await newDb();
  final store = newStore(api, db);
  final audioService = newAudioService();
  // final taskRunner = TaskRunner(api: api, db: db);

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(Root(
    store: store,
    sqlDb: db.sqlDb,
    audioService: audioService,
  ));
}

class Root extends StatefulWidget {
  Root({
    @required this.store,
    @required this.sqlDb,
    @required this.audioService,
  });

  final Store store;
  final SqlDb sqlDb;
  final AudioService audioService;

  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    widget.audioService.connect();
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
          create: (_) => widget.store,
        ),
        Provider<AppNavigationBloc>(
          create: (_) => AppNavigationBloc(),
          dispose: (_, value) => value.dispose(),
        ),
        Provider<AudioPlayerBloc>(
          create: (_) => AudioPlayerBloc(widget.store, widget.audioService),
          dispose: (_, value) => value.dispose(),
        ),
        Provider<UserBloc>(
          create: (_) => UserBloc(widget.store),
          dispose: (_, value) => value.dispose(),
        ),
        Provider<PodcastActionsBloc>(
          create: (_) => PodcastActionsBloc(widget.store),
          dispose: (_, value) => value.dispose(),
        ),
      ],
      child: Builder(builder: (context) {
        return MaterialApp(
          title: 'Phenopod',
          debugShowCheckedModeBanner: false,
          builder: (context, child) {
            return ScrollConfiguration(
              behavior: CustomScrollBehavior(),
              child: child,
            );
          },
          theme: appTheme,
          initialRoute: '/app',
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case '/app':
                return MaterialPageRoute(
                  builder: (context) => App(),
                );
              case '/queue':
                return PageRouteBuilder(
                  pageBuilder: (_, __, ___) => QueueScreen(),
                  transitionsBuilder: (_, animation, __, child) =>
                      SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0.0, 1.0),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  ),
                );
              case '/search':
                return PageRouteBuilder(
                  pageBuilder: (_, __, ___) => SearchScreen(),
                  transitionsBuilder: (_, animation, __, child) =>
                      SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0.0, 1.0),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  ),
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

class CustomScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
    BuildContext context,
    Widget child,
    AxisDirection axisDirection,
  ) {
    return child;
  }
}
