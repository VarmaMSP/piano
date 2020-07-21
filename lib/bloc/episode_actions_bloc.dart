// Package imports:
import 'package:rxdart/subjects.dart';
import 'package:super_enum/super_enum.dart';

// Project imports:
import 'package:phenopod/model/main.dart';
import 'package:phenopod/service/alarm_service/alarm_service.dart';
import 'package:phenopod/store/store.dart';
import 'package:phenopod/utils/file.dart' as fileutils;

part 'episode_actions_bloc.g.dart';

@superEnum
enum _EpisodeAction {
  @Data(fields: [
    DataField<Episode>('episode'),
    DataField<Podcast>('podcast'),
  ])
  StartDownload,
  @Data(fields: [DataField<String>('episodeId')])
  CancelDownload,
}

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
      await e.when(
        startDownload: (data) => _startDownload(data.episode, data.podcast),
        cancelDownload: (data) async {
          if (!await fileutils.hasStoragePermission()) {
            return;
          }
        },
      );
    });
  }

  Future<void> _startDownload(Episode episode, Podcast podcast) async {
    if (!await fileutils.hasStoragePermission()) {
      return;
    }

    /// Initial Storage settings, for now we are only using internal storage
    var storageSetting = await store.setting.watchStorageSetting().first;
    if (storageSetting.storage == Storage.none) {
      storageSetting = storageSetting.copyWith(
        storage: Storage.internalStorage,
        storagePath: await fileutils.getInternalStorageDirectory(),
      );
      await store.setting.saveStorageSetting(storageSetting);
    }

    /// Use a new random uuid as filename
    final filename = fileutils.newStorageFileName(episode.mediaUrl);
    final storagePath = storageSetting.storagePath;

    await store.audioFile.save(
      AudioFile.init(
        episode: episode,
        podcast: podcast,
        filename: filename,
        storagePath: storagePath,
      ),
    );
    await store.task.saveTask(
      Task.init(
        taskType: TaskType.downloadEpisode(
          episodeId: episode.id,
          url: episode.mediaUrl,
          filename: filename,
          storagePath: storagePath,
        ),
      ),
    );
    await alarmService.scheduleTaskRunnerOnce();
  }

  // Sink to add actions to processed
  void Function(EpisodeAction) get addAction => _actions.add;

  Future<void> dispose() async {
    await _actions.close();
  }
}
