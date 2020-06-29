import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moor_db_viewer/moor_db_viewer.dart';
import 'package:phenopod/animation/bottom_app_bar_animation.dart';
import 'package:phenopod/app/app_screen_bottom_view.dart';
import 'package:phenopod/app/app_screen_main_view.dart';
import 'package:phenopod/bloc/app_navigation_bloc.dart';
import 'package:phenopod/bloc/audio_player_bloc.dart';
import 'package:phenopod/model/main.dart';
import 'package:phenopod/service/sqldb/sqldb.dart';
import 'package:provider/provider.dart';

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
  void dispose() {
    _bottomAppBarController.dispose();
    _audioPlayerTabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final audioPlayerBloc = Provider.of<AudioPlayerBloc>(context);
    final appNavigationBloc = Provider.of<AppNavigationBloc>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size(0, 0),
        child: Container(),
      ),
      floatingActionButton: _buildFloatingActionBar(context),
      body: StreamBuilder<TabHistory>(
        initialData: TabHistory.init(),
        stream: appNavigationBloc.tabHistory,
        builder: (context, snapshot) {
          final tabHistory = snapshot.data;
          final tabNavigatorKeys = appNavigationBloc.tabNavigatorKeys;

          return WillPopScope(
            onWillPop: () async {
              // Close audio player if open
              if (_bottomAppBarAnimation.controller.value == 1.0) {
                _bottomAppBarAnimation.collapseBottomAppBar();
                return false;
              }
              // Pop route if possible
              final isFirstRoute =
                  !await tabNavigatorKeys[tabHistory.currentTab]
                      .currentState
                      .maybePop();
              // Show previous tab if you cannot pop route from current tab
              if (isFirstRoute && tabHistory.previousTab != null) {
                appNavigationBloc.popTab();
                return false;
              }
              // default to os
              return isFirstRoute;
            },
            child: StreamBuilder<AudioTrack>(
              stream: audioPlayerBloc.nowPlaying,
              builder: (context, snapshot) {
                final padding = !snapshot.hasData ? 56.0 : 102.0;

                return SafeArea(
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        bottom: padding,
                        child: Navigator(
                          initialRoute: '/main',
                          onGenerateRoute: (settings) {
                            switch (settings.name) {
                              case '/main':
                                return MaterialPageRoute(
                                  builder: (_) => AppScreenMainView(
                                    audioPlayerTabController:
                                        _audioPlayerTabController,
                                    bottomAppBarAnimation:
                                        _bottomAppBarAnimation,
                                  ),
                                );
                              default:
                                return null;
                            }
                          },
                        ),
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: AppScreenBottomView(
                          audioPlayerTabController: _audioPlayerTabController,
                          bottomAppBarAnimation: _bottomAppBarAnimation,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildFloatingActionBar(BuildContext context) {
    return kDebugMode
        ? FloatingActionButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => MoorDbViewer(Provider.of<SqlDb>(context)),
              ),
            ),
            mini: true,
            child: Icon(Icons.developer_mode, size: 22),
            backgroundColor: Colors.blue,
          )
        : null;
  }
}
