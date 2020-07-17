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
  @Data(fields: [DataField<Episode>('episode')])
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
        startDownload: (data) async {
          if (!await fileutils.hasStoragePermission()) {
            return;
          }

          final episode = data.episode;
          final audioFile = AudioFile.init(
            episode: episode,
            directory: await fileutils.getStorageDirectory(),
            filename: fileutils.newStorageFileName(episode.mediaUrl),
          );
          final downloadTask = Task.init(
            taskType: TaskType.downloadEpisode(
              episodeId: episode.id,
              url: episode.mediaUrl,
              filepath: audioFile.filepath,
            ),
          );

          await store.audioFile.save(audioFile);
          await store.task.saveTask(downloadTask);
          await alarmService.scheduleTaskRunnerOnce();
        },
        cancelDownload: (data) async {
          if (!await fileutils.hasStoragePermission()) {
            return;
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
