import 'package:phenopod/model/main.dart';
import 'package:phenopod/store/store.dart';
import 'package:rxdart/subjects.dart';
import 'package:super_enum/super_enum.dart';

part 'podcast_actions_bloc.g.dart';

@superEnum
enum _PodcastAction {
  @Data(fields: [
    DataField<String>('podcastId'),
    DataField<String>('podcastUrlParam'),
    DataField<bool>('synced'),
  ])
  Subscribed,
  @Data(fields: [
    DataField<String>('podcastId'),
    DataField<String>('podcastUrlParam'),
    DataField<bool>('synced'),
  ])
  Unsubscribed,
}

class PodcastActionsBloc {
  final Store store;

  /// Stream controller for actions
  final PublishSubject<PodcastAction> _actions =
      PublishSubject<PodcastAction>();

  PodcastActionsBloc(this.store);

  // Subscribe to podcast
  Future<void> subscribe(Podcast podcast) async {
    _actions.add(PodcastAction.subscribed(
      podcastId: podcast.id,
      podcastUrlParam: podcast.urlParam,
      synced: false,
    ));
    await store.subscription.subscribe(podcast.id);
    _actions.add(PodcastAction.subscribed(
      podcastId: podcast.id,
      podcastUrlParam: podcast.urlParam,
      synced: true,
    ));
  }

  // Unsubscribe to podcast
  Future<void> unsubscribe(Podcast podcast) async {
    _actions.add(PodcastAction.unsubscribed(
      podcastId: podcast.id,
      podcastUrlParam: podcast.urlParam,
      synced: false,
    ));
    await store.subscription.unsubscribe(podcast.id);
    _actions.add(PodcastAction.unsubscribed(
      podcastId: podcast.id,
      podcastUrlParam: podcast.urlParam,
      synced: true,
    ));
  }

  // Stream of actions
  Stream<PodcastAction> get actions => _actions.stream;

  Future<void> dispose() async {
    await _actions.close();
  }
}
