// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide BottomAppBar;
import 'package:flutter/services.dart';

// Package imports:
import 'package:moor_db_viewer/moor_db_viewer.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:phenopod/app/app_screen_content.dart';
import 'package:phenopod/bloc/app_navigation_bloc.dart';
import 'package:phenopod/bloc/audio_player_bloc.dart';
import 'package:phenopod/model/main.dart';
import 'package:phenopod/store/store.dart';
import 'package:phenopod/widgets/bottom_app_bar/main.dart';

class AppScreen extends StatelessWidget {
  const AppScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final audioPlayerBloc = Provider.of<AudioPlayerBloc>(context);
    final appNavigationBloc = Provider.of<AppNavigationBloc>(context);

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size(0, 0),
        child: Container(),
      ),
      floatingActionButton: _buildFloatingActionBar(context),
      body: WillPopScope(
        onWillPop: appNavigationBloc.onWillPop,
        child: StreamBuilder<AudioTrack>(
          stream: audioPlayerBloc.nowPlaying,
          builder: (context, snapshot) {
            return SafeArea(
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: !snapshot.hasData ? 56.0 : 102.0,
                    child: Navigator(
                      initialRoute: '/app',
                      onGenerateRoute: (settings) => settings.name == '/app'
                          ? MaterialPageRoute(
                              builder: (_) => AppScreenContent(),
                            )
                          : null,
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: BottomAppBar(),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildFloatingActionBar(BuildContext context) {
    return kDebugMode
        ? FloatingActionButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => MoorDbViewer(
                  Provider.of<Store>(context).db.sqlDb,
                ),
              ),
            ),
            mini: true,
            child: Icon(Icons.developer_mode, size: 22),
            backgroundColor: Colors.blue,
          )
        : null;
  }
}
