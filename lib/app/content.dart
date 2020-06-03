import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phenopod/animations/bottom_app_bar.dart';
import 'package:phenopod/blocs/audio_player/audio_player_bloc.dart';
import '../widgets/bottom_app_bar/main.dart' as appbar;

import '../route_generator.dart';

class AppContent extends StatefulWidget {
  const AppContent({Key key}) : super(key: key);

  @override
  _AppContentState createState() => _AppContentState();
}

class _AppContentState extends State<AppContent>
    with SingleTickerProviderStateMixin {
  AnimationController _bottomAppBarController;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final RouteObserver<PageRoute> routeObserver = RouteObserver();

  @override
  void initState() {
    super.initState();
    _bottomAppBarController = AnimationController(vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final bottomAppBarAnimations = BottomAppBarAnimations.New(
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
        appBar: PreferredSize(
          preferredSize: const Size(0, 0),
          child: Container(),
        ),
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              Builder(
                builder: (BuildContext context) {
                  return BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
                    bloc: BlocProvider.of<AudioPlayerBloc>(context),
                    builder: (BuildContext context, AudioPlayerState state) {
                      final padding = state is AudioPlayerActive ? 102.0 : 56.0;

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
                  );
                },
              ),
              Container(
                alignment: Alignment.bottomCenter,
                child: appbar.BottomAppBar(
                  animations: bottomAppBarAnimations,
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
    super.dispose();
  }
}
