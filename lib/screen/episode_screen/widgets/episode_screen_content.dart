// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

// Project imports:
import 'package:phenopod/bloc/app_navigation_bloc.dart';
import 'package:phenopod/model/main.dart';
import 'package:phenopod/widgets/html.dart';
import 'package:phenopod/widgets/podcast_thumbnail.dart';

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
          /// Padding for appbar
          Container(height: 0),

          /// Episode title
          Container(
            margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 18.0),
            child: Text(
              episode.title,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.headline4.copyWith(
                    height: 1.4,
                  ),
            ),
          ),

          /// Actions
          Container(
            margin: EdgeInsets.symmetric(vertical: 30.0),
            child: _buildActions(context),
          ),

          /// Podcast details
          Container(
            margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 18.0),
            child: _buildPodcastDetails(context),
          ),

          /// Episode description
          Container(
            margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
            child: HTML(id: episode.id, document: episode.description),
          ),
        ],
      ),
    );
  }

  Widget _buildPodcastDetails(BuildContext context) {
    final isSubscribed = false;

    return Row(
      children: [
        PodcastThumbnail(podcast: podcast, size: PodcastThumbnailSize.xs),
        Container(width: 10.0),
        Expanded(
          child: GestureDetector(
            onTap: () {
              Provider.of<AppNavigationBloc>(context, listen: false).pushScreen(
                AppScreen.podcastScreen(
                  urlParam: podcast.urlParam,
                  placeholder: PodcastPlaceholder(
                    title: podcast.title,
                    author: podcast.author,
                    isSubscribed: false,
                  ),
                ),
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  podcast.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headline6,
                ),
                Container(height: 6),
                Text(
                  podcast.author,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ],
            ),
          ),
        ),
        Container(width: 10.0),
        Container(
          height: 26,
          width: 120,
          child: FlatButton(
            onPressed: () {},
            color:
                isSubscribed ? Colors.grey.shade300 : TWColors.purple.shade600,
            textColor:
                isSubscribed ? Colors.grey.shade800 : Colors.grey.shade100,
            child: Text(
              isSubscribed ? 'SUBSCRIBED' : 'SUBSCRIBE',
              style: Theme.of(context).textTheme.headline6.copyWith(
                    color: isSubscribed ? Colors.grey.shade800 : Colors.white,
                    fontSize: 12.5,
                    letterSpacing: 0.4,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActions(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildActionButton(
            context,
            iconData: Icons.play_arrow_rounded,
            title: 'Play',
          ),
          Container(width: 10),
          _buildActionButton(
            context,
            iconData: Icons.download_rounded,
            title: 'Download',
          ),
          Container(width: 10),
          _buildActionButton(
            context,
            iconData: Icons.queue,
            title: 'Add to queue',
          ),
          Container(width: 10),
          _buildActionButton(
            context,
            iconData: Icons.share_rounded,
            title: 'Share',
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    String title,
    IconData iconData,
  }) {
    return Container(
      width: 90,
      child: Column(
        children: [
          Icon(iconData, size: 22, color: TWColors.gray.shade700),
          Container(height: 6),
          Text(title, style: Theme.of(context).textTheme.subtitle1),
        ],
      ),
    );
  }
}
