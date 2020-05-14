import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piano/blocs/audio_player/audio_player_bloc.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
import 'package:audioplayers/audioplayers.dart' as AP;

class AudioPlayer extends StatelessWidget {
  const AudioPlayer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //ignore: close_sinks
    final audioPlayerBloc = BlocProvider.of<AudioPlayerBloc>(context);

    return BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
      bloc: audioPlayerBloc,
      builder: (context, state) {
        if (state is AudioPlayerInitial) {
          return Container(height: 0);
        }

        final s = state as AudioPlayerLoaded;
        return Container(
          height: 50,
          padding: EdgeInsets.only(left: 13, right: 13),
          color: Colors.white,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Icon(
                Icons.expand_less,
                color: TWColors.gray.shade800,
                size: 22,
              ),
              Container(width: 10.0),
              Expanded(
                child: Text(
                  s.episode.title,
                  maxLines: 1,
                  // style: TextStyle(),
                ),
              ),
              StreamBuilder<Duration>(
                stream: s.duration,
                initialData: Duration.zero,
                builder: (context, snapshot1) {
                  final duration = snapshot1.data.inSeconds;

                  return StreamBuilder<Duration>(
                    stream: s.currentTime,
                    initialData: Duration.zero,
                    builder: (context, snapshot2) {
                      final currentTime = snapshot2.data.inSeconds;

                      return Container(
                        height: 32,
                        width: 32,
                        child: Stack(
                          children: [
                            CircularProgressIndicator(
                              value:
                                  duration > 0 ? currentTime / duration : null,
                              strokeWidth: 3.0,
                              backgroundColor: TWColors.gray.shade300,
                            ),
                            StreamBuilder<AP.AudioPlayerState>(
                              stream: s.playerState,
                              initialData: AP.AudioPlayerState.PAUSED,
                              builder: (context, snapshot3) {
                                final playerState = snapshot3.data;

                                IconData iconData;
                                if (playerState ==
                                    AP.AudioPlayerState.PLAYING) {
                                  iconData = Icons.pause;
                                } else {
                                  iconData = Icons.play_arrow;
                                }

                                return GestureDetector(
                                  onTap: () {
                                    if (playerState ==
                                        AP.AudioPlayerState.PLAYING) {
                                      audioPlayerBloc.add(Pause());
                                    }

                                    if (playerState ==
                                        AP.AudioPlayerState.PAUSED) {
                                      audioPlayerBloc.add(Play());
                                    }
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Icon(
                                      iconData,
                                      size: 20,
                                      color: TWColors.gray.shade800,
                                    ),
                                  ),
                                );
                              },
                            )
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
