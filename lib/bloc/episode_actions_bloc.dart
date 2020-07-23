// Package imports:
import 'package:rxdart/subjects.dart';

// Project imports:
import 'package:phenopod/model/main.dart';
import 'package:phenopod/service/alarm_service/alarm_service.dart';
import 'package:phenopod/store/store.dart';
import 'package:phenopod/utils/file.dart' as fileutils;

class EpisodeActionsBloc {
  final Store store;
  final AlarmService alarmService;

  /// Stream controller for actions
  final PublishSubject<EpisodeAction> _actions =
      PublishSubject<EpisodeAction>();

  EpisodeActionsBloc(this.store, this.alarmService) {
    _handleActions();
  }

  void _handleActions() {
    _actions.distinct().listen((e) async {
      await e.map(
        startDownload: (data) async {
          if (!await fileutils.hasStoragePermission()) {
            return;
          }
          await store.audioFile.download(
            episode: data.episode,
            podcast: data.podcast,
            storagePath:
                (await store.setting.watchStorageSetting().first).storagePath,
          );
          await alarmService.scheduleTaskRunner();
        },
        cancelDownload: (data) async {
          if (!await fileutils.hasStoragePermission()) {
            return;
          }
          await store.audioFile.deleteByEpisode(data.episodeId);
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
