import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piano/blocs/audio_player/audio_player_bloc.dart';
import 'package:piano/widgets/audio_player/main.dart';
import 'package:piano/widgets/navigation_bar.dart';

import '../route_generator.dart';

class App extends StatefulWidget {
  App({Key key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> with TickerProviderStateMixin {
  AnimationController _bottomAppBarController;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    _bottomAppBarController = new AnimationController(
      duration: const Duration(milliseconds: 20000),
      vsync: this,
    );
  }

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
              Builder(
                builder: (context) {
                  return BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
                    bloc: BlocProvider.of<AudioPlayerBloc>(context),
                    builder: (context, state) {
                      double padding;
                      if (state is AudioPlayerLoaded) {
                        padding = 106;
                      } else {
                        padding = 56;
                      }

                      return Container(
                        color: Colors.white,
                        padding: EdgeInsets.only(bottom: padding),
                        child: Navigator(
                          key: navigatorKey,
                          initialRoute: '/',
                          onGenerateRoute: RouteGenerator.generateRoute,
                        ),
                      );
                    },
                  );
                },
              ),
              Container(
                alignment: Alignment.bottomCenter,
                child: AudioPlayer(controller: _bottomAppBarController),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                child: NavigationBar(controller: _bottomAppBarController),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
