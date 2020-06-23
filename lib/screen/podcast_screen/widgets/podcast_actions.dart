import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:phenopod/model/main.dart';
import 'package:share/share.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

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
        color: TWColors.gray.shade800,
        size: 24,
      ),
      padding: const EdgeInsets.all(0),
      elevation: 3,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
      itemBuilder: (BuildContext context) {
        return <String>[
          'Share',
        ].map((String t) {
          return PopupMenuItem<String>(
            value: t,
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
