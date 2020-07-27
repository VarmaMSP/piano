// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

// Project imports:
import 'package:phenopod/bloc/app_navigation_bloc.dart';
import 'package:phenopod/model/main.dart';

class LibraryScreenContent extends StatelessWidget {
  const LibraryScreenContent({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GestureDetector(
            onTap: () {
              Provider.of<AppNavigationBloc>(context, listen: false)
                  .pushScreen(AppScreen.downloadsScreen());
            },
            behavior: HitTestBehavior.translucent,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      color: TWColors.red.shade200,
                      borderRadius: BorderRadius.circular(1000),
                    ),
                    child: Icon(
                      Icons.download_rounded,
                      size: 24,
                      color: TWColors.red.shade700,
                    ),
                  ),
                  Container(width: 20),
                  Expanded(
                    child: Text(
                      'Downloads',
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          .copyWith(color: TWColors.gray.shade900),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(height: 4),
          GestureDetector(
            onTap: () {
              Navigator.of(context, rootNavigator: true)
                  .pushNamed('/queue', arguments: <String, String>{});
            },
            behavior: HitTestBehavior.translucent,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      color: TWColors.green.shade200,
                      borderRadius: BorderRadius.circular(1000),
                    ),
                    child: Icon(
                      Icons.playlist_play_rounded,
                      size: 24,
                      color: TWColors.green.shade700,
                    ),
                  ),
                  Container(width: 20),
                  Expanded(
                    child: Text(
                      'Queue',
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          .copyWith(color: TWColors.gray.shade900),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
