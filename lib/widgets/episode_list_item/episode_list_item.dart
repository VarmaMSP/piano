// Flutter imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// Package imports:
import 'package:html_unescape/html_unescape_small.dart';
import 'package:phenopod/utils/request.dart';
import 'package:phenopod/utils/time.dart';
import 'package:provider/provider.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

// Project imports:
import 'package:phenopod/blocs/app_navigation_bloc.dart';
import 'package:phenopod/models/main.dart';
import 'package:phenopod/store/store.dart';
import 'package:phenopod/utils/utils.dart';
import 'package:phenopod/widgets/episode_menu.dart';

enum EpisodeListItemType {
  podcastItem,
  subscriptionsItem,
}

class EpisodeListItem extends StatelessWidget {
  const EpisodeListItem({
    Key key,
    @required this.episode,
    @required this.podcast,
    @required this.type,
  }) : super(key: key);

  static const thumbnailSize = 65.0;

  final Episode episode;
  final Podcast podcast;
  final EpisodeListItemType type;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<AppNavigationBloc>(context, listen: false)
            .pushScreen(AppScreen.episodeScreen(urlParam: episode.urlParam));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 6),
        padding: EdgeInsets.only(top: 12, right: 12, bottom: 10, left: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(14.0)),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildThumbnail(context),
                Container(width: 12),
                StreamBuilder<EpisodeMeta>(
                  stream:
                      Provider.of<Store>(context).episode.watchMeta(episode.id),
                  builder: (context, snapshot) {
                    return Expanded(
                      child: Container(
                        height: 65,
                        child: _buildInfo(context, snapshot.data),
                      ),
                    );
                  },
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 6.0),
              child: _buildEpisodeDescription(context),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildActionButton(context),
                Transform.translate(
                  offset: Offset(12, 3),
                  child: type == EpisodeListItemType.podcastItem
                      ? EpisodeMenu.episodeListItem(
                          episode: episode,
                          podcast: podcast,
                          episodeMeta: null,
                        )
                      : EpisodeMenu.subscriptionListItem(
                          episode: episode,
                          podcast: podcast,
                          episodeMeta: null,
                        ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildThumbnail(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(6.0)),
        border: Border.all(color: Colors.grey.shade400, width: 0.25),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(6.0)),
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
      ),
    );
  }

  Widget _buildInfo(BuildContext context, EpisodeMeta episodeMeta) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                episode.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.headline6.copyWith(
                      height: 1.35,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: TWColors.gray.shade900,
                    ),
              ),
              Container(height: 4),
              if (episodeMeta?.downloadProgress != null &&
                  !episodeMeta.downloadProgress.isComplete)
                _buildEpisodeDownloadInfo(context, episodeMeta.downloadProgress)
              else
                _buildEpisodeInfo(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEpisodeDownloadInfo(
    BuildContext context,
    DownloadProgress downloadProgress,
  ) {
    return Text(
      downloadProgress.isDownloading
          ? 'Downloading...  ${(downloadProgress.downloadPercentage * 100).round()}%'
          : 'Waiting to download...',
      style: Theme.of(context)
          .textTheme
          .headline6
          .copyWith(fontSize: 13, color: TWColors.blue.shade700),
    );
  }

  Widget _buildEpisodeInfo(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.headline6.copyWith(
              color: TWColors.gray.shade700,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
        children: <TextSpan>[
          TextSpan(text: formatRelativeTime(episode.pubDate)),
          if (type == EpisodeListItemType.subscriptionsItem) ...[
            TextSpan(
              text: '  ·  ',
              style: TextStyle(fontWeight: FontWeight.w900),
            ),
            TextSpan(text: podcast.title),
          ]
        ],
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildEpisodeDescription(BuildContext context) {
    return Text(
      HtmlUnescape()
          .convert(episode.summary)
          .replaceAll('\n', ' ')
          .replaceAll('&amp', '&')
          .trim(),
      style: Theme.of(context).textTheme.headline6.copyWith(
            fontSize: 13,
            color: TWColors.gray.shade700,
            fontWeight: FontWeight.w500,
            height: 1.45,
          ),
      textAlign: TextAlign.left,
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
    );
  }

  Widget _buildActionButton(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 38,
          width: 38,
          alignment: Alignment.centerLeft,
          child: SizedBox(
            height: 30,
            width: 30,
            child: Stack(
              children: <Widget>[
                CircularProgressIndicator(
                  strokeWidth: 2.5,
                  value: 0.0,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.purple.shade600,
                  ),
                  backgroundColor: TWColors.gray.shade400,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.play_arrow_rounded,
                    color: Colors.grey.shade600,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(width: 6.0),
        Text(
          formatDurationToWords(Duration(seconds: episode.duration)),
          style: Theme.of(context).textTheme.headline6.copyWith(
                fontSize: 13,
                color: TWColors.gray.shade700,
                fontWeight: FontWeight.w500,
              ),
        ),
      ],
    );
  }
}
