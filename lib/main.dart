// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:event_bus/event_bus.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:phenopod/app/app.dart';
import 'package:phenopod/blocs/app_navigation_bloc.dart';
import 'package:phenopod/blocs/audio_player_bloc.dart';
import 'package:phenopod/blocs/episode_actions_bloc.dart';
import 'package:phenopod/blocs/podcast_actions_bloc.dart';
import 'package:phenopod/blocs/user_bloc.dart';
import 'package:phenopod/page_route/slide_up_page_route.dart';
import 'package:phenopod/screens/queue_screen/queue_screen.dart';
import 'package:phenopod/screens/search_screen/search_screen.dart';
import 'package:phenopod/services/alarm_service/alarm_service.dart';
import 'package:phenopod/services/api/api.dart';
import 'package:phenopod/services/audio_service/audio_service.dart';
import 'package:phenopod/services/db/db.dart';
import 'package:phenopod/store/store.dart';
import 'package:phenopod/theme/theme.dart';
import 'package:phenopod/utils/chrome.dart' as chromeutils;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Global Services
  final db = await newDb();
  final api = await newApi();
  final eventBus = EventBus();
  final audioService = newAudioService();
  final alarmService = await newAlarmService();
  final store = newStore(api, db, alarmService);

  // Global Blocs
  final userBloc = UserBloc(store);
  final audioPlayerBloc = AudioPlayerBloc(store, audioService);
  final podcastActionsBloc = PodcastActionsBloc(store, eventBus);
  final episodeActionsBloc = EpisodeActionsBloc(store);

  await chromeutils.applyPreferredOrientations();

  // FIXME: calling this method, throws an error
  // await alarmService.scheduleTaskRunner();

  runApp(
    MultiProvider(
      providers: [
        Provider.value(
          value: db.sqlDb,
          updateShouldNotify: (_, __) => false,
        ),
        Provider.value(
          value: store,
          updateShouldNotify: (_, __) => false,
        ),
        Provider.value(
          value: eventBus,
          updateShouldNotify: (_, __) => false,
        ),
        Provider.value(
          value: userBloc,
          updateShouldNotify: (_, __) => false,
        ),
        Provider.value(
          value: audioPlayerBloc,
          updateShouldNotify: (_, __) => false,
        ),
        Provider.value(
          value: podcastActionsBloc,
          updateShouldNotify: (_, __) => false,
        ),
        Provider.value(
          value: episodeActionsBloc,
          updateShouldNotify: (_, __) => false,
        ),
      ],
      child: Root(audioService: audioService),
    ),
  );
}

class Root extends StatefulWidget {
  Root({@required this.audioService});

  final AudioService audioService;

  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  TabController _tabController;
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    widget.audioService.connect();
    _tabController = TabController(length: 2, initialIndex: 0, vsync: this);
    _animationController = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _tabController.dispose();
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
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.detached:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    chromeutils.applySystemUIOverlayStyle();

    return Provider(
      create: (_) => AppNavigationBloc(
        playerTabController: _tabController,
        playerAnimationController: _animationController,
      ),
      dispose: (_, value) => value.dispose(),
      child: Builder(builder: (context) {
        return MaterialApp(
          title: 'Phenopod',
          debugShowCheckedModeBanner: false,
          builder: (context, child) => ScrollConfiguration(
            behavior: CustomScrollBehavior(),
            child: child,
          ),
          theme: appTheme,
          initialRoute: '/app',
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case '/app':
                return SlideUpPageRoute.i(builder: (_) => App());
              case '/queue':
                return SlideUpPageRoute.b(builder: (_) => QueueScreen());
              case '/search':
                return SlideUpPageRoute.b(builder: (_) => SearchScreen());
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
