import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piano/blocs/audio_player/audio_player_bloc.dart';

class AudioPlayer extends StatelessWidget {
  const AudioPlayer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
      bloc: BlocProvider.of<AudioPlayerBloc>(context),
      builder: (context, state) {
        if (state is AudioPlayerInitial) {
          return Container(height: 0);
        }

        final s = state as AudioPlayerLoaded;
        return Container(
          height: 24,
          color: Colors.white,
          child: Text(s.episode.title),
        );
      },
    );
  }
}
