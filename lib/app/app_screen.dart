import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moor_db_viewer/moor_db_viewer.dart';
import 'package:phenopod/animation/bottom_app_bar_animation.dart';
import 'package:phenopod/bloc/app_navigation_bloc.dart';
import 'package:phenopod/bloc/audio_player_bloc.dart';
import 'package:phenopod/model/main.dart';
import 'package:phenopod/service/sqldb/sqldb.dart';
import 'package:phenopod/widgets/bottom_app_bar/main.dart' as appbar;
import 'package:provider/provider.dart';

import 'app_router.dart';

class AppScreen extends StatefulWidget {
  const AppScreen({
    Key key,
    this.height,
  }) : super(key: key);

  final double height;

  @override
  _AppScreenState createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> with TickerProviderStateMixin {
  TabController _audioPlayerTabController;
  AnimationController _bottomAppBarController;
  BottomAppBarAnimation _bottomAppBarAnimation;

  final RouteObserver<PageRoute> routeObserver = RouteObserver();

  @override
  void initState() {
    super.initState();
    _audioPlayerTabController = TabController(
      length: 2,
      initialIndex: 0,
      vsync: this,
    );
    _bottomAppBarController = AnimationController(
      vsync: this,
    );
    _bottomAppBarAnimation = BottomAppBarAnimation.New(
      widget.height,
      _audioPlayerTabController,
      _bottomAppBarController,
    );
  }

  @override
  Widget build(BuildContext context) {
    final navigationBloc = Provider.of<AppNavigationBloc>(context);

    return WillPopScope(
      onWillPop: () async {
        if (_bottomAppBarAnimation.controller.value == 1.0) {
          _bottomAppBarAnimation.collapseBottomAppBar();
          return false;
        }
        return !await navigationBloc.homeTabNavigatorKey.currentState
            .maybePop();
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
                      key: navigationBloc.homeTabNavigatorKey,
                      initialRoute: '/',
                      observers: [routeObserver],
                      onGenerateRoute: makeGenerateRoute(routeObserver),
                    ),
                  );
                },
              ),
              Container(
                alignment: Alignment.bottomCenter,
                child: appbar.BottomAppBar(
                  animations: _bottomAppBarAnimation,
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
