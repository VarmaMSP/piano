// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:share/share.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

// Project imports:
import 'package:phenopod/models/main.dart';

class PodcastActions extends StatelessWidget {
  const PodcastActions({
    Key key,
    @required this.podcast,
  }) : super(key: key);

  final Podcast podcast;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Icon(
        Icons.more_vert,
        color: TWColors.gray.shade600,
        size: 24,
      ),
      padding: const EdgeInsets.only(top: 0, bottom: 0),
      elevation: 8,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
      itemBuilder: (BuildContext context) {
        return <String>[
          'Share',
        ].map((String t) {
          return PopupMenuItem<String>(
            value: t,
            textStyle: Theme.of(context)
                .textTheme
                .subtitle1
                .copyWith(color: TWColors.gray.shade900, fontSize: 16.5),
            child: Text(t),
          );
        }).toList();
      },
      onSelected: (value) {
        switch (value) {
          case 'Share':
            Share.share('https://phenopod.com/podcasts/${podcast.urlParam}');
            return;
        }
      },
    );
  }
}
