import 'package:flutter/material.dart';
import 'package:phenopod/animations/bottom_app_bar.dart';
import 'package:phenopod/bloc/audio_player_bloc.dart';
import 'package:phenopod/model/main.dart';
import 'package:phenopod/widgets/bottom_app_bar/main.dart' as appbar;
import 'package:phenopod/route_generator.dart';
import 'package:provider/provider.dart';

class App extends StatefulWidget {
  const App({Key key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> with SingleTickerProviderStateMixin {
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
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: const Size(0, 0),
          child: Container(),
        ),
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              StreamBuilder<AudioPlayerSnapshot>(
                initialData: null,
                stream: Provider.of<AudioPlayerBloc>(context).snapshot,
                builder: (context, snapshot) {
                  final padding = snapshot.hasData ? 102.0 : 56.0;

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
