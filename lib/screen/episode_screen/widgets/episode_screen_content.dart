// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:phenopod/model/main.dart';

class EpisodeScreenContent extends StatelessWidget {
  final Episode episode;
  final Podcast podcast;

  const EpisodeScreenContent({
    Key key,
    @required this.episode,
    @required this.podcast,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(height: 10),
          _buildPodcastDetails(context),
          Container(height: 10),
          _buildEpisodeDetails(context),
          Container(height: 10),
        ],
      ),
    );
  }

  Widget _buildPodcastDetails(BuildContext context) {
    return Row(
      children: [Text(podcast.title)],
    );
  }

  Widget _buildEpisodeDetails(BuildContext context) {
    return Text(episode.title * 1000);
  }
}
