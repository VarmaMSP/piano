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
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 6),
        padding: EdgeInsets.only(top: 12, right: 10, bottom: 4, left: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(14.0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildThumbnail(context),
                Expanded(
                  child: Container(
                    height: thumbnailSize,
                    padding: const EdgeInsets.only(left: 12.0, right: 10.0),
                    child: _buildInfo(context),
                  ),
                ),
                Container(
                  height: thumbnailSize,
                  child: _buildActionButton(context),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(child: _buildEpisodeDescription(context)),
                  Container(width: 6.0),
                  _buildMenu(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenu(BuildContext context) {
    return StreamBuilder<EpisodeMeta>(
      stream: Provider.of<Store>(context).episode.watchMeta(episode.id),
      builder: (context, snapshot) {
        return type == EpisodeListItemType.podcastItem
            ? EpisodeMenu.episodeListItem(
                episode: episode,
                podcast: podcast,
                episodeMeta: snapshot.data,
              )
            : EpisodeMenu.subscriptionListItem(
                episode: episode,
                podcast: podcast,
                episodeMeta: snapshot.data,
              );
      },
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

  Widget _buildInfo(BuildContext context) {
    return StreamBuilder<EpisodeMeta>(
      stream: Provider.of<Store>(context).episode.watchMeta(episode.id),
      builder: (context, snapshot) {
        final progress = snapshot.data?.downloadProgress;

        return Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Transform.translate(
              offset: Offset(0, -4),
              child: Text(
                episode.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.headline6.copyWith(
                      height: 1.3,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.5,
                      color: TWColors.gray.shade900,
                    ),
              ),
            ),
            Container(height: 0),
            if (progress != null && !progress.isComplete)
              _buildEpisodeDownloadInfo(context, progress)
            else
              _buildEpisodeInfo(context),
          ],
        );
      },
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
      style: Theme.of(context).textTheme.headline6.copyWith(
            fontSize: 12.5,
            color: TWColors.blue.shade700,
            fontWeight: FontWeight.w400,
          ),
    );
  }

  Widget _buildEpisodeInfo(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.subtitle1.copyWith(
              fontSize: 13,
              color: TWColors.gray.shade900,
              fontWeight: FontWeight.w500,
              height: 1.3,
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
      style: Theme.of(context).textTheme.subtitle1.copyWith(
            fontSize: 12.5,
            color: TWColors.gray.shade900,
            fontWeight: FontWeight.w500,
            height: 1.45,
          ),
      textAlign: TextAlign.left,
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
    );
  }

  Widget _buildActionButton(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 38,
          width: 38,
          alignment: Alignment.center,
          child: SizedBox(
            height: 32,
            width: 32,
            child: Stack(
              children: <Widget>[
                CircularProgressIndicator(
                  strokeWidth: 2.5,
                  value: 0.0,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.purple.shade600,
                  ),
                  backgroundColor: TWColors.gray.shade300,
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
        Container(height: 6.0),
        Text(
          formatDurationToWords(Duration(seconds: episode.duration)),
          style: Theme.of(context).textTheme.subtitle1.copyWith(
                fontSize: 11,
                color: TWColors.gray.shade900,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.15,
              ),
        ),
      ],
    );
  }
}
