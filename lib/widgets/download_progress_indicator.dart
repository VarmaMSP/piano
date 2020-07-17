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
      height: 16,
      width: 16,
      margin: EdgeInsets.only(right: 14),
      child: Icon(
        MdiIcons.checkUnderline,
        size: 16,
        color: TWColors.purple.shade600,
      ),
    );
  }

  Widget _buildDownloading(AudioFile audioFile) {
    return Container(
      height: 16,
      width: 16,
      padding: EdgeInsets.all(7.8),
      margin: EdgeInsets.only(right: 14),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 255, 255, 0.45),
        borderRadius: BorderRadius.circular(100),
      ),
      child: CircularProgressIndicator(
        value: audioFile.downloadPercentage,
        valueColor: AlwaysStoppedAnimation<Color>(
          TWColors.purple.shade600,
        ),
        backgroundColor: TWColors.gray.shade300,
        strokeWidth: 14,
      ),
    );
  }
}
