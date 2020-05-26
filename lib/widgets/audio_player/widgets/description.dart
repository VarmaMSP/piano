import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:phenopod/blocs/audio_player/audio_player_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class Description extends StatelessWidget {
  const Description({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
        bloc: BlocProvider.of<AudioPlayerBloc>(context),
        builder: (context, state) {
          if (state is AudioPlayerActive) {
            return Html(
              data: state.playingNow.episode.description,
              onLinkTap: (url) async {
                if (await canLaunch(url)) {
                  await launch(url);
                }
              },
              style: {
                '*': Style(
                  letterSpacing: 0.15,
                ),
                'h1, h2, h3, h4': Style(
                  fontSize: FontSize.large,
                  color: TWColors.gray.shade700,
                ),
                'a': Style(
                  color: TWColors.blue.shade600,
                ),
              },
            );
          }

          return Text('');
        },
      ),
    );
  }
}
