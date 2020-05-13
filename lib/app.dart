import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piano/blocs/audio_player/audio_player_bloc.dart';
import 'package:piano/route_generator.dart';
import 'package:piano/widgets/bottom_navigation_bar/bottom_navigation_bar.dart';

class App extends StatefulWidget {
  App({Key key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return !await navigatorKey.currentState.maybePop();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size(0, 0),
          child: Container(),
        ),
        body: MultiBlocProvider(
          providers: [
            BlocProvider<AudioPlayerBloc>(
              create: (context) => AudioPlayerBloc(),
            ),
          ],
          child: Stack(
            children: <Widget>[
              Container(
                color: Colors.white,
                padding: EdgeInsets.only(bottom: 56),
                child: Navigator(
                  key: navigatorKey,
                  initialRoute: '/',
                  onGenerateRoute: RouteGenerator.generateRoute,
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                child: AppBottomNavigationBar(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
