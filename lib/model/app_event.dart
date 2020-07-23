part of 'main.dart';

@freezed
abstract class AppEvent with _$AppEvent {
  const factory AppEvent.subscribeToPodcast({
    @required Podcast podcast,
    @required bool synced,
  }) = _SubscribeToPodcast;

  const factory AppEvent.unsubscribeFromPodcast({
    @required Podcast podcast,
    @required bool synced,
  }) = _UnsubscribeFromPodcast;
}
