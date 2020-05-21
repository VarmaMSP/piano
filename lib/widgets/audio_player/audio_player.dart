import 'package:flutter/material.dart';
import 'package:phenopod/blocs/audio_player/main.dart';
import 'package:audio_service/audio_service.dart';

class AudioPlayer extends StatelessWidget {
  const AudioPlayer({
    Key key,
    @required this.state,
    @required this.onPlay,
    @required this.onPause,
  }) : super(key: key);

  final AudioPlayerActive state;
  final Function onPlay;
  final Function onPause;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Container(
        constraints: const BoxConstraints.expand(height: 350),
        color: Colors.black45,
        child: Column(
          children: <Widget>[
            Text(state.episode.title),
            Container(height: 40),
            StreamBuilder<PlaybackState>(
              stream: AudioService.playbackStateStream,
              builder: (BuildContext context,
                  AsyncSnapshot<PlaybackState> snapshot) {
                return Text(snapshot.data?.basicState.toString());
              },
            )
          ],
        ),
      ),
    );
  }
}
