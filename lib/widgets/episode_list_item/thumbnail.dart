import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:piano/models/episode.dart';
import 'package:piano/models/podcast.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
import 'package:transparent_image/transparent_image.dart';

class Thumbnail extends StatelessWidget {
  final Episode episode;
  final Podcast podcast;

  const Thumbnail({
    Key key,
    @required this.episode,
    @required this.podcast,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var imageUrl =
        'https://cdn.phenopod.com/thumbnails/${podcast.urlParam}.jpg';
    var width = 85.0;

    final image = ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: imageUrl,
        height: width,
        width: width,
      ),
    );

    final playIconBg = Container(
      height: width,
      width: width,
      alignment: Alignment.center,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(600.0),
        child: Container(
          color: Color.fromRGBO(0, 0, 0, 0.55),
          height: 38.0,
          width: 38.0,
        ),
      ),
    );

    final playIcon = Container(
      height: width,
      width: width,
      alignment: Alignment.center,
      child: Icon(
        Icons.play_arrow,
        color: Colors.white,
        size: 28,
      ),
    );

    final duration = Container(
      height: width,
      width: width,
      alignment: Alignment(0.96, 0.96),
      decoration: BoxDecoration(
        border: Border.all(
          color: TWColors.gray.shade400,
          width: 0.4,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: _duration(episode.duration),
    );

    // final progressbar = Container(
    //   height: 5,
    //   child: Stack(
    //     children: <Widget>[
    //       FractionallySizedBox(
    //         heightFactor: 1.0,
    //         widthFactor: 1.0,
    //         child: Container(
    //           decoration: BoxDecoration(
    //             borderRadius: BorderRadius.all(Radius.circular(600)),
    //             color: TWColors.gray.shade300,
    //           ),
    //         ),
    //       ),
    //       FractionallySizedBox(
    //         heightFactor: 1.0,
    //         widthFactor: 0.34,
    //         child: Container(
    //           decoration: BoxDecoration(
    //             borderRadius: BorderRadius.all(Radius.circular(600)),
    //             color: TWColors.red.shade700,
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );

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
        Container(
          width: width,
          padding: EdgeInsets.only(top: 10),
          // child: progressbar,
        ),
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
}
