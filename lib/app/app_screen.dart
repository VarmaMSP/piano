// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide BottomAppBar;

// Package imports:
import 'package:moor_db_viewer/moor_db_viewer.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:phenopod/app/app_screen_content.dart';
import 'package:phenopod/blocs/app_navigation_bloc.dart';
import 'package:phenopod/models/main.dart';
import 'package:phenopod/services/db/db.dart';
import 'package:phenopod/store/store.dart';
import 'package:phenopod/utils/chrome.dart' as chromeutils;
import 'package:phenopod/widgets/bottom_app_bar/main.dart';

class AppScreen extends StatelessWidget {
  const AppScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<Store>(context);
    final appNavigationBloc = Provider.of<AppNavigationBloc>(context);

    chromeutils.applySystemUIOverlayStyle();

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
          initialData: store.audioPlayer.getQueue().nowPlaying,
          stream: store.audioPlayer.watchQueue().map((q) => q.nowPlaying),
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
                    child: RepaintBoundary(child: BottomAppBar()),
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
