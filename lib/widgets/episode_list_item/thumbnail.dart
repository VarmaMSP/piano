import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:phenopod/bloc/audio_player_bloc.dart';
import 'package:phenopod/model/main.dart';
import 'package:phenopod/store/store.dart';
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
    final store = Provider.of<Store>(context);
    final audioPlayerBloc = Provider.of<AudioPlayerBloc>(context);

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
      child: _buildDuration(episode.duration),
    );

    final Widget progresbar = Container(
      alignment: Alignment.bottomCenter,
      child: StreamBuilder<AudioTrack>(
        stream: Provider.of<AudioPlayerBloc>(context).nowPlaying,
        builder: (context, snapshot) =>
            snapshot?.data?.episode?.id == episode.id
                ? StreamBuilder<Playback>(
                    stream: store.playback.watch(episode.id),
                    builder: (context, snapshot) => _buildProgressbar(
                      snapshot.data,
                    ),
                  )
                : FutureBuilder<Playback>(
                    future: store.playback.get_(episode.id),
                    builder: (context, snapshot) => _buildProgressbar(
                      snapshot.data,
                    ),
                  ),
      ),
    );

    return GestureDetector(
      onTap: () {
        audioPlayerBloc.transistionQueue(QueueTransistion.playAudioTrack(
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
            progresbar,
          ],
        ),
      ),
    );
  }

  Widget _buildDuration(int sec) {
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
    if (res == null) {
      return null;
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(5.0),
      child: Container(
        color: const Color.fromRGBO(0, 0, 0, 0.7),
        padding: const EdgeInsets.only(left: 4, right: 4, top: 1.9),
        child: Text(
          res ?? '00:00',
          style: TextStyle(
            fontSize: 11.5,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            height: 1,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }

  Widget _buildProgressbar(Playback playback) {
    if (playback == null || playback.isEmpty) {
      return Container(height: 0);
    }

    return Container(
      height: 6,
      width: thumbnailSize,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        color: const Color.fromRGBO(0, 0, 0, 0.55),
      ),
      alignment: Alignment.centerLeft,
      child: FractionallySizedBox(
        heightFactor: 1.0,
        widthFactor: playback.position.inSeconds / playback.duration.inSeconds,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(4)),
            color: TWColors.yellow.shade400,
          ),
        ),
      ),
    );
  }
}
