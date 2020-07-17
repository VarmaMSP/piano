import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:phenopod/model/main.dart';
import 'package:phenopod/store/store.dart';
import 'package:provider/provider.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class DownloadProgressIndicator extends StatelessWidget {
  const DownloadProgressIndicator({
    Key key,
    @required this.episodeId,
  }) : super(key: key);

  final String episodeId;

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<Store>(context);

    return StreamBuilder<AudioFile>(
      stream: store.audioFile.watchByEpisode(episodeId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }

        return AnimatedSwitcher(
          duration: Duration(milliseconds: 400),
          child: snapshot.data.isComplete &&
                  snapshot.data.downloadPercentage == 1.0
              ? _buildDownloaded()
              : _buildDownloading(snapshot.data),
        );
      },
    );
  }

  Widget _buildDownloaded() {
    return Container(
      margin: EdgeInsets.only(right: 10),
      child: Icon(
        MdiIcons.checkUnderlineCircle,
        size: 14,
        color: TWColors.blue.shade700,
      ),
    );
  }

  Widget _buildDownloading(AudioFile audioFile) {
    return Container(
      height: 10,
      width: 10,
      margin: EdgeInsets.only(right: 12, bottom: 2),
      child: CircularProgressIndicator(
        value: audioFile.downloadPercentage,
        valueColor: AlwaysStoppedAnimation<Color>(TWColors.blue.shade700),
        backgroundColor: TWColors.gray.shade400,
        strokeWidth: 2.5,
      ),
    );
  }
}
