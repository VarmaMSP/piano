// Package imports:
import 'package:rxdart/subjects.dart';

// Project imports:
import 'package:phenopod/models/main.dart';
import 'package:phenopod/store/store.dart';
import 'package:phenopod/utils/file.dart' as fileutils;

class EpisodeActionsBloc {
  final Store store;

  /// Stream controller for actions
  final PublishSubject<EpisodeAction> _actions =
      PublishSubject<EpisodeAction>();

  EpisodeActionsBloc(this.store) {
    _handleActions();
  }

  void _handleActions() {
    _actions.distinct().listen((e) async {
      await e.map(
        startDownload: (data) async {
          if (await fileutils.hasStoragePermission()) {
            final setting = await store.setting.watchStorageSetting().first;
            await store.audioFile.download(
              episode: data.episode,
              podcast: data.podcast,
              storagePath: setting.storagePath,
            );
          }
        },
        cancelDownload: (data) async {
          if (await fileutils.hasStoragePermission()) {
            await store.audioFile.deleteByEpisode(data.episodeId);
          }
        },
      );
    });
  }

  // Sink to add actions to processed
  void Function(EpisodeAction) get addAction => _actions.add;

  Future<void> dispose() async {
    await _actions.close();
  }
}
