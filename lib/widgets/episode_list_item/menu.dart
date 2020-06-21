import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:phenopod/bloc/audio_player_bloc.dart';
import 'package:phenopod/model/main.dart';
import 'package:provider/provider.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class Menu extends StatelessWidget {
  const Menu({
    Key key,
    @required this.episode,
    @required this.podcast,
  }) : super(key: key);

  final Episode episode;
  final Podcast podcast;

  @override
  Widget build(BuildContext context) {
    final audioPlayerBloc = Provider.of<AudioPlayerBloc>(context);

    return Container(
      height: 39,
      child: PopupMenuButton<String>(
        icon: Icon(
          Icons.more_vert,
          color: TWColors.gray.shade600,
          size: 20,
        ),
        padding: const EdgeInsets.all(0),
        elevation: 3,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
        itemBuilder: (BuildContext context) {
          return <String>[
            'Play Next',
            'Add to queue',
          ].map((String t) {
            return PopupMenuItem<String>(
              value: t,
              child: Text(t),
            );
          }).toList();
        },
        onSelected: (value) {
          switch (value) {
            case 'Play Next':
              audioPlayerBloc.transistionSnapshot(
                SnapshotTransistion.addToQueueTop(
                  audioTrack: AudioTrack(
                    episode: episode,
                    podcast: podcast,
                  ),
                ),
              );
              break;
            case 'Add to queue':
              break;
          }
        },
      ),
    );
  }
}
