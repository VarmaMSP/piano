import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:piano/models/episode.dart';
import 'package:piano/models/podcast.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
// import 'package:transparent_image/transparent_image.dart';

class Thumbnail extends StatelessWidget {
  static final double thumbnailSize = 88;
  static final String thumbnailUrl = 'https://cdn.phenopod.com/thumbnails';

  const Thumbnail({
    Key key,
    @required this.episode,
    @required this.podcast,
  }) : super(key: key);

  final Episode episode;
  final Podcast podcast;

  @override
  Widget build(BuildContext context) {
    final image = ClipRRect(
      borderRadius: BorderRadius.circular(6.0),
      child: CachedNetworkImage(
        imageUrl: '$thumbnailUrl/${podcast.urlParam}.jpg',
        fit: BoxFit.fill,
        height: thumbnailSize,
        width: thumbnailSize,
        placeholder: (context, url) => Container(
          height: thumbnailSize,
          width: thumbnailSize,
          color: TWColors.gray.shade300,
        ),
      ),
    );

    final playIconBg = Container(
      height: thumbnailSize,
      width: thumbnailSize,
      alignment: Alignment.center,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(600.0),
        child: Container(
          color: Color.fromRGBO(0, 0, 0, 0.45),
          height: 38.0,
          width: 38.0,
        ),
      ),
    );

    final playIcon = Container(
      height: thumbnailSize,
      width: thumbnailSize,
      alignment: Alignment.center,
      child: Icon(
        Icons.play_arrow,
        color: Colors.white,
        size: 28,
      ),
    );

    final duration = Container(
      height: thumbnailSize,
      width: thumbnailSize,
      alignment: Alignment(1, 1),
      decoration: BoxDecoration(
        border: Border.all(
          color: TWColors.gray.shade400,
          width: 0.3,
        ),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: _duration(episode.duration),
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Stack(
          children: <Widget>[
            image,
            playIconBg,
            playIcon,
            duration,
          ],
        ),
        Container(height: 8),
        _progressbar(),
        Container(height: 9),
      ],
    );
  }

  Widget _duration(int sec) {
    RegExp regex;
    if (sec < 60 * 60) {
      regex = RegExp(r'\d\d:(\d\d:\d\d)');
    } else if (sec < 10 * 60 * 60) {
      regex = RegExp(r'\d(\d:\d\d:\d\d)');
    } else {
      regex = RegExp(r'(\d\d:\d\d:\d\d)');
    }

    var res = regex
        .firstMatch(DateTime(0, 0, 0, 0, 0, sec).toIso8601String())
        ?.group(1);

    if (res != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(5.0),
        child: Container(
          color: Color.fromRGBO(0, 0, 0, 0.75),
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Text(
            res ?? '00:00',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              height: 1.35,
              letterSpacing: 0.35,
            ),
          ),
        ),
      );
    }

    return null;
  }

  Widget _progressbar() {
    if (episode.lastPlayedAt == "") {
      return Container(height: 4.5);
    }

    return Container(
      height: 4.5,
      width: thumbnailSize,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(600)),
        color: TWColors.gray.shade300,
      ),
      alignment: Alignment.centerLeft,
      child: FractionallySizedBox(
        heightFactor: 1.0,
        widthFactor: episode.progress + 0.5,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(600)),
            color: TWColors.red.shade700,
          ),
        ),
      ),
    );
  }
}
