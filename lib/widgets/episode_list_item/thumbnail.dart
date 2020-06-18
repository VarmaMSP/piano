import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:phenopod/bloc/audio_player_bloc.dart';
import 'package:phenopod/model/main.dart';
import 'package:phenopod/utils/request.dart';
import 'package:provider/provider.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class Thumbnail extends StatelessWidget {
  const Thumbnail({
    Key key,
    @required this.episode,
    @required this.podcast,
  }) : super(key: key);

  static const double thumbnailSize = 90;

  final Episode episode;
  final Podcast podcast;

  @override
  Widget build(BuildContext context) {
    final Widget image = ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: CachedNetworkImage(
        imageUrl: '$thumbnailUrl/${podcast.urlParam}.jpg',
        fit: BoxFit.fill,
        height: thumbnailSize,
        width: thumbnailSize,
        placeholder: (BuildContext context, String url) => Container(
          height: thumbnailSize,
          width: thumbnailSize,
          color: TWColors.gray.shade300,
        ),
      ),
    );

    final Widget playIconBg = Container(
      height: thumbnailSize,
      width: thumbnailSize,
      alignment: Alignment.center,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(600.0),
        child: Container(
          color: const Color.fromRGBO(0, 0, 0, 0.4),
          height: 34.0,
          width: 34.0,
        ),
      ),
    );

    final Widget playIcon = Container(
      height: thumbnailSize,
      width: thumbnailSize,
      alignment: Alignment.center,
      child: Icon(
        Icons.play_arrow,
        color: Colors.white,
        size: 26,
      ),
    );

    final Widget duration = Container(
      alignment: const Alignment(0.87, 0.85),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(1.0),
      ),
      child: _duration(episode.duration),
    );

    final audioPlayerBloc = Provider.of<AudioPlayerBloc>(context);

    return GestureDetector(
      onTap: () {
        audioPlayerBloc.transistionSnapshot(SnapshotTransistion.playAudioTrack(
          audioTrack: AudioTrack(
            position: 0,
            episode: episode,
            podcast: podcast,
          ),
        ));
      },
      child: Container(
        height: thumbnailSize,
        width: thumbnailSize,
        child: Stack(
          children: <Widget>[
            image,
            playIconBg,
            playIcon,
            duration,
            Container(
              alignment: Alignment.bottomCenter,
              child: _progressbar(),
            )
          ],
        ),
      ),
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

    final res = regex
        .firstMatch(DateTime(0, 0, 0, 0, 0, sec).toIso8601String())
        ?.group(1);

    if (res != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(5.0),
        child: Container(
          color: const Color.fromRGBO(0, 0, 0, 0.65),
          padding: const EdgeInsets.only(left: 4, right: 4, bottom: 0.9),
          child: Text(
            res ?? '00:00',
            style: TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              height: 1.3,
              letterSpacing: 0.5,
            ),
          ),
        ),
      );
    }

    return null;
  }

  Widget _progressbar() {
    if (episode.lastPlayedAt == '') {
      return Container(height: 0);
    }

    return Container(
      height: 6.25,
      width: thumbnailSize,
      decoration: BoxDecoration(
        border: Border.all(color: TWColors.gray.shade300, width: 1),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(2),
          bottomRight: Radius.circular(2),
        ),
        color: TWColors.gray.shade100,
      ),
      alignment: Alignment.centerLeft,
      child: FractionallySizedBox(
        heightFactor: 1.0,
        widthFactor: episode.progress + 0.27,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(2),
              bottomRight: Radius.circular(2),
            ),
            color: TWColors.red.shade600,
          ),
        ),
      ),
    );
  }
}
