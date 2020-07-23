part of 'main.dart';

@freezed
abstract class AppEvent with _$AppEvent {
  const factory AppEvent.subscribe({
    @required Podcast podcast,
    @required bool synced,
  }) = _Subscribe;

  const factory AppEvent.unsubscribe({
    @required Podcast podcast,
    @required bool synced,
  }) = _Unsubscribe;
}
