// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

// Project imports:
import 'package:phenopod/model/main.dart';
import 'package:phenopod/utils/utils.dart';
import 'package:phenopod/widgets/episode_menu.dart';
import 'package:phenopod/widgets/queue_list_item/thumbnail.dart';

class DownloadListItem extends StatelessWidget {
  DownloadListItem({
    Key key,
    @required this.audioFile,
  });

  static final double itemHeight = 80;

  final AudioFile audioFile;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        constraints: BoxConstraints.expand(height: itemHeight),
        padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 18.0),
        margin: EdgeInsets.only(top: 2.0, bottom: 2.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Thumbnail(podcast: audioFile.podcast, lighten: false),
            Expanded(child: _buildDetails(context)),
            EpisodeMenu.downloadListItem(
              episode: audioFile.episode,
              podcast: audioFile.podcast,
              downloadProgress: audioFile.downloadProgress,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetails(BuildContext context, {bool lighten}) {
    return Container(
      padding: EdgeInsets.only(left: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            audioFile.episode.title,
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(color: TWColors.gray.shade900),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            audioFile.podcast.title,
            style: Theme.of(context)
                .textTheme
                .subtitle1
                .copyWith(color: TWColors.gray.shade900),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          audioFile.isComplete
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(
                      MdiIcons.checkUnderlineCircle,
                      size: 14,
                      color: TWColors.blue.shade700,
                    ),
                    Container(width: 10),
                    Text(
                      '${formatDuration(seconds: audioFile.episode.duration)}',
                      style: Theme.of(context).textTheme.subtitle2.copyWith(
                          color: TWColors.gray.shade900, fontSize: 11.75),
                    ),
                  ],
                )
              : Text(
                  audioFile.isDownloading
                      ? 'Downloading...  ${(audioFile.downloadPercentage * 100).round()}%'
                      : 'Waiting to download...',
                  style: Theme.of(context).textTheme.subtitle2.copyWith(
                        fontSize: 12.5,
                        color: TWColors.blue.shade700,
                      ),
                ),
        ],
      ),
    );
  }
}
