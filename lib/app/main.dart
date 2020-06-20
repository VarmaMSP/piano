import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moor_db_viewer/moor_db_viewer.dart';
import 'package:phenopod/animation/bottom_app_bar_animation.dart';
import 'package:phenopod/bloc/audio_player_bloc.dart';
import 'package:phenopod/model/main.dart';
import 'package:phenopod/service/sqldb/sqldb.dart';
import 'package:phenopod/widgets/bottom_app_bar/main.dart' as appbar;
import 'package:phenopod/route_generator.dart';
import 'package:provider/provider.dart';

class App extends StatefulWidget {
  const App({Key key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> with TickerProviderStateMixin {
  AnimationController _bottomAppBarController;
  TabController _audioPlayerTabController;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final RouteObserver<PageRoute> routeObserver = RouteObserver();

  @override
  void initState() {
    super.initState();
    _bottomAppBarController = AnimationController(vsync: this);
    _audioPlayerTabController = TabController(
      length: 2,
      initialIndex: 0,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottomAppBarAnimations = BottomAppBarAnimation.New(
      context,
      _bottomAppBarController,
    );

    return WillPopScope(
      onWillPop: () async {
        if (bottomAppBarAnimations.controller.value == 1.0) {
          bottomAppBarAnimations.collapseBottomAppBar();
          return false;
        }
        return !await navigatorKey.currentState.maybePop();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: const Size(0, 0),
          child: Container(),
        ),
        floatingActionButton: kDebugMode
            ? FloatingActionButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => MoorDbViewer(
                      Provider.of<SqlDb>(context),
                    ),
                  ),
                ),
                mini: true,
                child: Icon(Icons.developer_mode, size: 22),
                backgroundColor: Colors.blue,
              )
            : null,
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              StreamBuilder<AudioTrack>(
                initialData: null,
                stream: Provider.of<AudioPlayerBloc>(context).nowPlaying,
                builder: (context, snapshot) {
                  final padding = !snapshot.hasData ? 56.0 : 102.0;

                  return Container(
                    color: Colors.white,
                    padding: EdgeInsets.only(bottom: padding),
                    child: Navigator(
                      key: navigatorKey,
                      initialRoute: '/',
                      observers: [routeObserver],
                      onGenerateRoute:
                          RouteGenerator.makeGenerateRoute(routeObserver),
                    ),
                  );
                },
              ),
              Container(
                alignment: Alignment.bottomCenter,
                child: appbar.BottomAppBar(
                  animations: bottomAppBarAnimations,
                  audioPlayerTabController: _audioPlayerTabController,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _bottomAppBarController.dispose();
    _audioPlayerTabController.dispose();
    super.dispose();
  }
}
