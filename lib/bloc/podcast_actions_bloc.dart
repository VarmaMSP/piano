// Package imports:
import 'package:event_bus/event_bus.dart';
import 'package:phenopod/service/alarm_service/alarm_service.dart';
import 'package:rxdart/subjects.dart';

// Project imports:
import 'package:phenopod/model/main.dart';
import 'package:phenopod/store/store.dart';

class PodcastActionsBloc {
  final Store store;
  final EventBus eventBus;
  final AlarmService alarmService;

  /// Stream controller for actions
  final PublishSubject<PodcastAction> _actions =
      PublishSubject<PodcastAction>();

  PodcastActionsBloc(this.store, this.eventBus, this.alarmService) {
    _handleActions();
  }

  void _handleActions() {
    _actions.distinct().listen((e) async {
      await e.map(
        subscribe: (data) async {
          eventBus.fire(AppEvent.subscribeToPodcast(
            podcast: data.podcast,
            synced: false,
          ));
          await store.subscription.subscribe(data.podcast);
          eventBus.fire(AppEvent.subscribeToPodcast(
            podcast: data.podcast,
            synced: true,
          ));

          // final cachePodcastTask = Task.init(
          //   taskType: TaskType.cachePodcast(
          //     podcastId: data.podcast.id,
          //     podcastUrlParam: data.podcast.urlParam,
          //   ),
          // );
          // await store.task.saveTask(cachePodcastTask);
          // await alarmService.scheduleTaskRunner();
        },
        unsubscribe: (data) async {
          eventBus.fire(AppEvent.unsubscribeFromPodcast(
            podcast: data.podcast,
            synced: false,
          ));
          await store.subscription.unsubscribe(data.podcast);
          eventBus.fire(AppEvent.unsubscribeFromPodcast(
            podcast: data.podcast,
            synced: true,
          ));
        },
      );
    });
  }

  // Sink to add actions to processed
  void Function(PodcastAction) get addAction => _actions.add;

  Future<void> dispose() async {
    await _actions.close();
  }
}
