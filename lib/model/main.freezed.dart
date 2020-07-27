// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'main.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

class _$PodcastActionTearOff {
  const _$PodcastActionTearOff();

// ignore: unused_element
  _Subscribe subscribe({@required Podcast podcast}) {
    return _Subscribe(
      podcast: podcast,
    );
  }

// ignore: unused_element
  _Unsubscribe unsubscribe({@required Podcast podcast}) {
    return _Unsubscribe(
      podcast: podcast,
    );
  }
}

// ignore: unused_element
const $PodcastAction = _$PodcastActionTearOff();

mixin _$PodcastAction {
  Podcast get podcast;

  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result subscribe(Podcast podcast),
    @required Result unsubscribe(Podcast podcast),
  });
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result subscribe(Podcast podcast),
    Result unsubscribe(Podcast podcast),
    @required Result orElse(),
  });
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result subscribe(_Subscribe value),
    @required Result unsubscribe(_Unsubscribe value),
  });
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result subscribe(_Subscribe value),
    Result unsubscribe(_Unsubscribe value),
    @required Result orElse(),
  });

  $PodcastActionCopyWith<PodcastAction> get copyWith;
}

abstract class $PodcastActionCopyWith<$Res> {
  factory $PodcastActionCopyWith(
          PodcastAction value, $Res Function(PodcastAction) then) =
      _$PodcastActionCopyWithImpl<$Res>;
  $Res call({Podcast podcast});
}

class _$PodcastActionCopyWithImpl<$Res>
    implements $PodcastActionCopyWith<$Res> {
  _$PodcastActionCopyWithImpl(this._value, this._then);

  final PodcastAction _value;
  // ignore: unused_field
  final $Res Function(PodcastAction) _then;

  @override
  $Res call({
    Object podcast = freezed,
  }) {
    return _then(_value.copyWith(
      podcast: podcast == freezed ? _value.podcast : podcast as Podcast,
    ));
  }
}

abstract class _$SubscribeCopyWith<$Res>
    implements $PodcastActionCopyWith<$Res> {
  factory _$SubscribeCopyWith(
          _Subscribe value, $Res Function(_Subscribe) then) =
      __$SubscribeCopyWithImpl<$Res>;
  @override
  $Res call({Podcast podcast});
}

class __$SubscribeCopyWithImpl<$Res> extends _$PodcastActionCopyWithImpl<$Res>
    implements _$SubscribeCopyWith<$Res> {
  __$SubscribeCopyWithImpl(_Subscribe _value, $Res Function(_Subscribe) _then)
      : super(_value, (v) => _then(v as _Subscribe));

  @override
  _Subscribe get _value => super._value as _Subscribe;

  @override
  $Res call({
    Object podcast = freezed,
  }) {
    return _then(_Subscribe(
      podcast: podcast == freezed ? _value.podcast : podcast as Podcast,
    ));
  }
}

class _$_Subscribe implements _Subscribe {
  const _$_Subscribe({@required this.podcast}) : assert(podcast != null);

  @override
  final Podcast podcast;

  @override
  String toString() {
    return 'PodcastAction.subscribe(podcast: $podcast)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Subscribe &&
            (identical(other.podcast, podcast) ||
                const DeepCollectionEquality().equals(other.podcast, podcast)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(podcast);

  @override
  _$SubscribeCopyWith<_Subscribe> get copyWith =>
      __$SubscribeCopyWithImpl<_Subscribe>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result subscribe(Podcast podcast),
    @required Result unsubscribe(Podcast podcast),
  }) {
    assert(subscribe != null);
    assert(unsubscribe != null);
    return subscribe(podcast);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result subscribe(Podcast podcast),
    Result unsubscribe(Podcast podcast),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (subscribe != null) {
      return subscribe(podcast);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result subscribe(_Subscribe value),
    @required Result unsubscribe(_Unsubscribe value),
  }) {
    assert(subscribe != null);
    assert(unsubscribe != null);
    return subscribe(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result subscribe(_Subscribe value),
    Result unsubscribe(_Unsubscribe value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (subscribe != null) {
      return subscribe(this);
    }
    return orElse();
  }
}

abstract class _Subscribe implements PodcastAction {
  const factory _Subscribe({@required Podcast podcast}) = _$_Subscribe;

  @override
  Podcast get podcast;
  @override
  _$SubscribeCopyWith<_Subscribe> get copyWith;
}

abstract class _$UnsubscribeCopyWith<$Res>
    implements $PodcastActionCopyWith<$Res> {
  factory _$UnsubscribeCopyWith(
          _Unsubscribe value, $Res Function(_Unsubscribe) then) =
      __$UnsubscribeCopyWithImpl<$Res>;
  @override
  $Res call({Podcast podcast});
}

class __$UnsubscribeCopyWithImpl<$Res> extends _$PodcastActionCopyWithImpl<$Res>
    implements _$UnsubscribeCopyWith<$Res> {
  __$UnsubscribeCopyWithImpl(
      _Unsubscribe _value, $Res Function(_Unsubscribe) _then)
      : super(_value, (v) => _then(v as _Unsubscribe));

  @override
  _Unsubscribe get _value => super._value as _Unsubscribe;

  @override
  $Res call({
    Object podcast = freezed,
  }) {
    return _then(_Unsubscribe(
      podcast: podcast == freezed ? _value.podcast : podcast as Podcast,
    ));
  }
}

class _$_Unsubscribe implements _Unsubscribe {
  const _$_Unsubscribe({@required this.podcast}) : assert(podcast != null);

  @override
  final Podcast podcast;

  @override
  String toString() {
    return 'PodcastAction.unsubscribe(podcast: $podcast)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Unsubscribe &&
            (identical(other.podcast, podcast) ||
                const DeepCollectionEquality().equals(other.podcast, podcast)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(podcast);

  @override
  _$UnsubscribeCopyWith<_Unsubscribe> get copyWith =>
      __$UnsubscribeCopyWithImpl<_Unsubscribe>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result subscribe(Podcast podcast),
    @required Result unsubscribe(Podcast podcast),
  }) {
    assert(subscribe != null);
    assert(unsubscribe != null);
    return unsubscribe(podcast);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result subscribe(Podcast podcast),
    Result unsubscribe(Podcast podcast),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (unsubscribe != null) {
      return unsubscribe(podcast);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result subscribe(_Subscribe value),
    @required Result unsubscribe(_Unsubscribe value),
  }) {
    assert(subscribe != null);
    assert(unsubscribe != null);
    return unsubscribe(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result subscribe(_Subscribe value),
    Result unsubscribe(_Unsubscribe value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (unsubscribe != null) {
      return unsubscribe(this);
    }
    return orElse();
  }
}

abstract class _Unsubscribe implements PodcastAction {
  const factory _Unsubscribe({@required Podcast podcast}) = _$_Unsubscribe;

  @override
  Podcast get podcast;
  @override
  _$UnsubscribeCopyWith<_Unsubscribe> get copyWith;
}

class _$EpisodeActionTearOff {
  const _$EpisodeActionTearOff();

// ignore: unused_element
  _StartDownload startDownload(
      {@required Episode episode, @required Podcast podcast}) {
    return _StartDownload(
      episode: episode,
      podcast: podcast,
    );
  }

// ignore: unused_element
  _CancelDownload cancelDownload({@required String episodeId}) {
    return _CancelDownload(
      episodeId: episodeId,
    );
  }
}

// ignore: unused_element
const $EpisodeAction = _$EpisodeActionTearOff();

mixin _$EpisodeAction {
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result startDownload(Episode episode, Podcast podcast),
    @required Result cancelDownload(String episodeId),
  });
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result startDownload(Episode episode, Podcast podcast),
    Result cancelDownload(String episodeId),
    @required Result orElse(),
  });
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result startDownload(_StartDownload value),
    @required Result cancelDownload(_CancelDownload value),
  });
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result startDownload(_StartDownload value),
    Result cancelDownload(_CancelDownload value),
    @required Result orElse(),
  });
}

abstract class $EpisodeActionCopyWith<$Res> {
  factory $EpisodeActionCopyWith(
          EpisodeAction value, $Res Function(EpisodeAction) then) =
      _$EpisodeActionCopyWithImpl<$Res>;
}

class _$EpisodeActionCopyWithImpl<$Res>
    implements $EpisodeActionCopyWith<$Res> {
  _$EpisodeActionCopyWithImpl(this._value, this._then);

  final EpisodeAction _value;
  // ignore: unused_field
  final $Res Function(EpisodeAction) _then;
}

abstract class _$StartDownloadCopyWith<$Res> {
  factory _$StartDownloadCopyWith(
          _StartDownload value, $Res Function(_StartDownload) then) =
      __$StartDownloadCopyWithImpl<$Res>;
  $Res call({Episode episode, Podcast podcast});
}

class __$StartDownloadCopyWithImpl<$Res>
    extends _$EpisodeActionCopyWithImpl<$Res>
    implements _$StartDownloadCopyWith<$Res> {
  __$StartDownloadCopyWithImpl(
      _StartDownload _value, $Res Function(_StartDownload) _then)
      : super(_value, (v) => _then(v as _StartDownload));

  @override
  _StartDownload get _value => super._value as _StartDownload;

  @override
  $Res call({
    Object episode = freezed,
    Object podcast = freezed,
  }) {
    return _then(_StartDownload(
      episode: episode == freezed ? _value.episode : episode as Episode,
      podcast: podcast == freezed ? _value.podcast : podcast as Podcast,
    ));
  }
}

class _$_StartDownload implements _StartDownload {
  const _$_StartDownload({@required this.episode, @required this.podcast})
      : assert(episode != null),
        assert(podcast != null);

  @override
  final Episode episode;
  @override
  final Podcast podcast;

  @override
  String toString() {
    return 'EpisodeAction.startDownload(episode: $episode, podcast: $podcast)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _StartDownload &&
            (identical(other.episode, episode) ||
                const DeepCollectionEquality()
                    .equals(other.episode, episode)) &&
            (identical(other.podcast, podcast) ||
                const DeepCollectionEquality().equals(other.podcast, podcast)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(episode) ^
      const DeepCollectionEquality().hash(podcast);

  @override
  _$StartDownloadCopyWith<_StartDownload> get copyWith =>
      __$StartDownloadCopyWithImpl<_StartDownload>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result startDownload(Episode episode, Podcast podcast),
    @required Result cancelDownload(String episodeId),
  }) {
    assert(startDownload != null);
    assert(cancelDownload != null);
    return startDownload(episode, podcast);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result startDownload(Episode episode, Podcast podcast),
    Result cancelDownload(String episodeId),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (startDownload != null) {
      return startDownload(episode, podcast);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result startDownload(_StartDownload value),
    @required Result cancelDownload(_CancelDownload value),
  }) {
    assert(startDownload != null);
    assert(cancelDownload != null);
    return startDownload(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result startDownload(_StartDownload value),
    Result cancelDownload(_CancelDownload value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (startDownload != null) {
      return startDownload(this);
    }
    return orElse();
  }
}

abstract class _StartDownload implements EpisodeAction {
  const factory _StartDownload(
      {@required Episode episode,
      @required Podcast podcast}) = _$_StartDownload;

  Episode get episode;
  Podcast get podcast;
  _$StartDownloadCopyWith<_StartDownload> get copyWith;
}

abstract class _$CancelDownloadCopyWith<$Res> {
  factory _$CancelDownloadCopyWith(
          _CancelDownload value, $Res Function(_CancelDownload) then) =
      __$CancelDownloadCopyWithImpl<$Res>;
  $Res call({String episodeId});
}

class __$CancelDownloadCopyWithImpl<$Res>
    extends _$EpisodeActionCopyWithImpl<$Res>
    implements _$CancelDownloadCopyWith<$Res> {
  __$CancelDownloadCopyWithImpl(
      _CancelDownload _value, $Res Function(_CancelDownload) _then)
      : super(_value, (v) => _then(v as _CancelDownload));

  @override
  _CancelDownload get _value => super._value as _CancelDownload;

  @override
  $Res call({
    Object episodeId = freezed,
  }) {
    return _then(_CancelDownload(
      episodeId: episodeId == freezed ? _value.episodeId : episodeId as String,
    ));
  }
}

class _$_CancelDownload implements _CancelDownload {
  const _$_CancelDownload({@required this.episodeId})
      : assert(episodeId != null);

  @override
  final String episodeId;

  @override
  String toString() {
    return 'EpisodeAction.cancelDownload(episodeId: $episodeId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _CancelDownload &&
            (identical(other.episodeId, episodeId) ||
                const DeepCollectionEquality()
                    .equals(other.episodeId, episodeId)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(episodeId);

  @override
  _$CancelDownloadCopyWith<_CancelDownload> get copyWith =>
      __$CancelDownloadCopyWithImpl<_CancelDownload>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result startDownload(Episode episode, Podcast podcast),
    @required Result cancelDownload(String episodeId),
  }) {
    assert(startDownload != null);
    assert(cancelDownload != null);
    return cancelDownload(episodeId);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result startDownload(Episode episode, Podcast podcast),
    Result cancelDownload(String episodeId),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (cancelDownload != null) {
      return cancelDownload(episodeId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result startDownload(_StartDownload value),
    @required Result cancelDownload(_CancelDownload value),
  }) {
    assert(startDownload != null);
    assert(cancelDownload != null);
    return cancelDownload(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result startDownload(_StartDownload value),
    Result cancelDownload(_CancelDownload value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (cancelDownload != null) {
      return cancelDownload(this);
    }
    return orElse();
  }
}

abstract class _CancelDownload implements EpisodeAction {
  const factory _CancelDownload({@required String episodeId}) =
      _$_CancelDownload;

  String get episodeId;
  _$CancelDownloadCopyWith<_CancelDownload> get copyWith;
}

class _$QueueActionTearOff {
  const _$QueueActionTearOff();

// ignore: unused_element
  _PlayTrack playTrack({@required AudioTrack audioTrack}) {
    return _PlayTrack(
      audioTrack: audioTrack,
    );
  }

// ignore: unused_element
  _PlayTrackAt playTrackAt({@required int position}) {
    return _PlayTrackAt(
      position: position,
    );
  }

// ignore: unused_element
  _AddToQueueTop addToQueueTop({@required AudioTrack audioTrack}) {
    return _AddToQueueTop(
      audioTrack: audioTrack,
    );
  }

// ignore: unused_element
  _AddToQueueBottom addToQueueBottom({@required AudioTrack audioTrack}) {
    return _AddToQueueBottom(
      audioTrack: audioTrack,
    );
  }

// ignore: unused_element
  _ChangeTrackPosition changeTrackPosition(
      {@required int from, @required int to}) {
    return _ChangeTrackPosition(
      from: from,
      to: to,
    );
  }

// ignore: unused_element
  _RemoveTrack removeTrack({@required int position}) {
    return _RemoveTrack(
      position: position,
    );
  }

// ignore: unused_element
  _ClearQueue clearQueue() {
    return const _ClearQueue();
  }
}

// ignore: unused_element
const $QueueAction = _$QueueActionTearOff();

mixin _$QueueAction {
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result playTrack(AudioTrack audioTrack),
    @required Result playTrackAt(int position),
    @required Result addToQueueTop(AudioTrack audioTrack),
    @required Result addToQueueBottom(AudioTrack audioTrack),
    @required Result changeTrackPosition(int from, int to),
    @required Result removeTrack(int position),
    @required Result clearQueue(),
  });
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result playTrack(AudioTrack audioTrack),
    Result playTrackAt(int position),
    Result addToQueueTop(AudioTrack audioTrack),
    Result addToQueueBottom(AudioTrack audioTrack),
    Result changeTrackPosition(int from, int to),
    Result removeTrack(int position),
    Result clearQueue(),
    @required Result orElse(),
  });
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result playTrack(_PlayTrack value),
    @required Result playTrackAt(_PlayTrackAt value),
    @required Result addToQueueTop(_AddToQueueTop value),
    @required Result addToQueueBottom(_AddToQueueBottom value),
    @required Result changeTrackPosition(_ChangeTrackPosition value),
    @required Result removeTrack(_RemoveTrack value),
    @required Result clearQueue(_ClearQueue value),
  });
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result playTrack(_PlayTrack value),
    Result playTrackAt(_PlayTrackAt value),
    Result addToQueueTop(_AddToQueueTop value),
    Result addToQueueBottom(_AddToQueueBottom value),
    Result changeTrackPosition(_ChangeTrackPosition value),
    Result removeTrack(_RemoveTrack value),
    Result clearQueue(_ClearQueue value),
    @required Result orElse(),
  });
}

abstract class $QueueActionCopyWith<$Res> {
  factory $QueueActionCopyWith(
          QueueAction value, $Res Function(QueueAction) then) =
      _$QueueActionCopyWithImpl<$Res>;
}

class _$QueueActionCopyWithImpl<$Res> implements $QueueActionCopyWith<$Res> {
  _$QueueActionCopyWithImpl(this._value, this._then);

  final QueueAction _value;
  // ignore: unused_field
  final $Res Function(QueueAction) _then;
}

abstract class _$PlayTrackCopyWith<$Res> {
  factory _$PlayTrackCopyWith(
          _PlayTrack value, $Res Function(_PlayTrack) then) =
      __$PlayTrackCopyWithImpl<$Res>;
  $Res call({AudioTrack audioTrack});
}

class __$PlayTrackCopyWithImpl<$Res> extends _$QueueActionCopyWithImpl<$Res>
    implements _$PlayTrackCopyWith<$Res> {
  __$PlayTrackCopyWithImpl(_PlayTrack _value, $Res Function(_PlayTrack) _then)
      : super(_value, (v) => _then(v as _PlayTrack));

  @override
  _PlayTrack get _value => super._value as _PlayTrack;

  @override
  $Res call({
    Object audioTrack = freezed,
  }) {
    return _then(_PlayTrack(
      audioTrack:
          audioTrack == freezed ? _value.audioTrack : audioTrack as AudioTrack,
    ));
  }
}

class _$_PlayTrack implements _PlayTrack {
  const _$_PlayTrack({@required this.audioTrack}) : assert(audioTrack != null);

  @override
  final AudioTrack audioTrack;

  @override
  String toString() {
    return 'QueueAction.playTrack(audioTrack: $audioTrack)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _PlayTrack &&
            (identical(other.audioTrack, audioTrack) ||
                const DeepCollectionEquality()
                    .equals(other.audioTrack, audioTrack)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(audioTrack);

  @override
  _$PlayTrackCopyWith<_PlayTrack> get copyWith =>
      __$PlayTrackCopyWithImpl<_PlayTrack>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result playTrack(AudioTrack audioTrack),
    @required Result playTrackAt(int position),
    @required Result addToQueueTop(AudioTrack audioTrack),
    @required Result addToQueueBottom(AudioTrack audioTrack),
    @required Result changeTrackPosition(int from, int to),
    @required Result removeTrack(int position),
    @required Result clearQueue(),
  }) {
    assert(playTrack != null);
    assert(playTrackAt != null);
    assert(addToQueueTop != null);
    assert(addToQueueBottom != null);
    assert(changeTrackPosition != null);
    assert(removeTrack != null);
    assert(clearQueue != null);
    return playTrack(audioTrack);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result playTrack(AudioTrack audioTrack),
    Result playTrackAt(int position),
    Result addToQueueTop(AudioTrack audioTrack),
    Result addToQueueBottom(AudioTrack audioTrack),
    Result changeTrackPosition(int from, int to),
    Result removeTrack(int position),
    Result clearQueue(),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (playTrack != null) {
      return playTrack(audioTrack);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result playTrack(_PlayTrack value),
    @required Result playTrackAt(_PlayTrackAt value),
    @required Result addToQueueTop(_AddToQueueTop value),
    @required Result addToQueueBottom(_AddToQueueBottom value),
    @required Result changeTrackPosition(_ChangeTrackPosition value),
    @required Result removeTrack(_RemoveTrack value),
    @required Result clearQueue(_ClearQueue value),
  }) {
    assert(playTrack != null);
    assert(playTrackAt != null);
    assert(addToQueueTop != null);
    assert(addToQueueBottom != null);
    assert(changeTrackPosition != null);
    assert(removeTrack != null);
    assert(clearQueue != null);
    return playTrack(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result playTrack(_PlayTrack value),
    Result playTrackAt(_PlayTrackAt value),
    Result addToQueueTop(_AddToQueueTop value),
    Result addToQueueBottom(_AddToQueueBottom value),
    Result changeTrackPosition(_ChangeTrackPosition value),
    Result removeTrack(_RemoveTrack value),
    Result clearQueue(_ClearQueue value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (playTrack != null) {
      return playTrack(this);
    }
    return orElse();
  }
}

abstract class _PlayTrack implements QueueAction {
  const factory _PlayTrack({@required AudioTrack audioTrack}) = _$_PlayTrack;

  AudioTrack get audioTrack;
  _$PlayTrackCopyWith<_PlayTrack> get copyWith;
}

abstract class _$PlayTrackAtCopyWith<$Res> {
  factory _$PlayTrackAtCopyWith(
          _PlayTrackAt value, $Res Function(_PlayTrackAt) then) =
      __$PlayTrackAtCopyWithImpl<$Res>;
  $Res call({int position});
}

class __$PlayTrackAtCopyWithImpl<$Res> extends _$QueueActionCopyWithImpl<$Res>
    implements _$PlayTrackAtCopyWith<$Res> {
  __$PlayTrackAtCopyWithImpl(
      _PlayTrackAt _value, $Res Function(_PlayTrackAt) _then)
      : super(_value, (v) => _then(v as _PlayTrackAt));

  @override
  _PlayTrackAt get _value => super._value as _PlayTrackAt;

  @override
  $Res call({
    Object position = freezed,
  }) {
    return _then(_PlayTrackAt(
      position: position == freezed ? _value.position : position as int,
    ));
  }
}

class _$_PlayTrackAt implements _PlayTrackAt {
  const _$_PlayTrackAt({@required this.position}) : assert(position != null);

  @override
  final int position;

  @override
  String toString() {
    return 'QueueAction.playTrackAt(position: $position)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _PlayTrackAt &&
            (identical(other.position, position) ||
                const DeepCollectionEquality()
                    .equals(other.position, position)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(position);

  @override
  _$PlayTrackAtCopyWith<_PlayTrackAt> get copyWith =>
      __$PlayTrackAtCopyWithImpl<_PlayTrackAt>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result playTrack(AudioTrack audioTrack),
    @required Result playTrackAt(int position),
    @required Result addToQueueTop(AudioTrack audioTrack),
    @required Result addToQueueBottom(AudioTrack audioTrack),
    @required Result changeTrackPosition(int from, int to),
    @required Result removeTrack(int position),
    @required Result clearQueue(),
  }) {
    assert(playTrack != null);
    assert(playTrackAt != null);
    assert(addToQueueTop != null);
    assert(addToQueueBottom != null);
    assert(changeTrackPosition != null);
    assert(removeTrack != null);
    assert(clearQueue != null);
    return playTrackAt(position);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result playTrack(AudioTrack audioTrack),
    Result playTrackAt(int position),
    Result addToQueueTop(AudioTrack audioTrack),
    Result addToQueueBottom(AudioTrack audioTrack),
    Result changeTrackPosition(int from, int to),
    Result removeTrack(int position),
    Result clearQueue(),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (playTrackAt != null) {
      return playTrackAt(position);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result playTrack(_PlayTrack value),
    @required Result playTrackAt(_PlayTrackAt value),
    @required Result addToQueueTop(_AddToQueueTop value),
    @required Result addToQueueBottom(_AddToQueueBottom value),
    @required Result changeTrackPosition(_ChangeTrackPosition value),
    @required Result removeTrack(_RemoveTrack value),
    @required Result clearQueue(_ClearQueue value),
  }) {
    assert(playTrack != null);
    assert(playTrackAt != null);
    assert(addToQueueTop != null);
    assert(addToQueueBottom != null);
    assert(changeTrackPosition != null);
    assert(removeTrack != null);
    assert(clearQueue != null);
    return playTrackAt(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result playTrack(_PlayTrack value),
    Result playTrackAt(_PlayTrackAt value),
    Result addToQueueTop(_AddToQueueTop value),
    Result addToQueueBottom(_AddToQueueBottom value),
    Result changeTrackPosition(_ChangeTrackPosition value),
    Result removeTrack(_RemoveTrack value),
    Result clearQueue(_ClearQueue value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (playTrackAt != null) {
      return playTrackAt(this);
    }
    return orElse();
  }
}

abstract class _PlayTrackAt implements QueueAction {
  const factory _PlayTrackAt({@required int position}) = _$_PlayTrackAt;

  int get position;
  _$PlayTrackAtCopyWith<_PlayTrackAt> get copyWith;
}

abstract class _$AddToQueueTopCopyWith<$Res> {
  factory _$AddToQueueTopCopyWith(
          _AddToQueueTop value, $Res Function(_AddToQueueTop) then) =
      __$AddToQueueTopCopyWithImpl<$Res>;
  $Res call({AudioTrack audioTrack});
}

class __$AddToQueueTopCopyWithImpl<$Res> extends _$QueueActionCopyWithImpl<$Res>
    implements _$AddToQueueTopCopyWith<$Res> {
  __$AddToQueueTopCopyWithImpl(
      _AddToQueueTop _value, $Res Function(_AddToQueueTop) _then)
      : super(_value, (v) => _then(v as _AddToQueueTop));

  @override
  _AddToQueueTop get _value => super._value as _AddToQueueTop;

  @override
  $Res call({
    Object audioTrack = freezed,
  }) {
    return _then(_AddToQueueTop(
      audioTrack:
          audioTrack == freezed ? _value.audioTrack : audioTrack as AudioTrack,
    ));
  }
}

class _$_AddToQueueTop implements _AddToQueueTop {
  const _$_AddToQueueTop({@required this.audioTrack})
      : assert(audioTrack != null);

  @override
  final AudioTrack audioTrack;

  @override
  String toString() {
    return 'QueueAction.addToQueueTop(audioTrack: $audioTrack)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _AddToQueueTop &&
            (identical(other.audioTrack, audioTrack) ||
                const DeepCollectionEquality()
                    .equals(other.audioTrack, audioTrack)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(audioTrack);

  @override
  _$AddToQueueTopCopyWith<_AddToQueueTop> get copyWith =>
      __$AddToQueueTopCopyWithImpl<_AddToQueueTop>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result playTrack(AudioTrack audioTrack),
    @required Result playTrackAt(int position),
    @required Result addToQueueTop(AudioTrack audioTrack),
    @required Result addToQueueBottom(AudioTrack audioTrack),
    @required Result changeTrackPosition(int from, int to),
    @required Result removeTrack(int position),
    @required Result clearQueue(),
  }) {
    assert(playTrack != null);
    assert(playTrackAt != null);
    assert(addToQueueTop != null);
    assert(addToQueueBottom != null);
    assert(changeTrackPosition != null);
    assert(removeTrack != null);
    assert(clearQueue != null);
    return addToQueueTop(audioTrack);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result playTrack(AudioTrack audioTrack),
    Result playTrackAt(int position),
    Result addToQueueTop(AudioTrack audioTrack),
    Result addToQueueBottom(AudioTrack audioTrack),
    Result changeTrackPosition(int from, int to),
    Result removeTrack(int position),
    Result clearQueue(),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (addToQueueTop != null) {
      return addToQueueTop(audioTrack);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result playTrack(_PlayTrack value),
    @required Result playTrackAt(_PlayTrackAt value),
    @required Result addToQueueTop(_AddToQueueTop value),
    @required Result addToQueueBottom(_AddToQueueBottom value),
    @required Result changeTrackPosition(_ChangeTrackPosition value),
    @required Result removeTrack(_RemoveTrack value),
    @required Result clearQueue(_ClearQueue value),
  }) {
    assert(playTrack != null);
    assert(playTrackAt != null);
    assert(addToQueueTop != null);
    assert(addToQueueBottom != null);
    assert(changeTrackPosition != null);
    assert(removeTrack != null);
    assert(clearQueue != null);
    return addToQueueTop(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result playTrack(_PlayTrack value),
    Result playTrackAt(_PlayTrackAt value),
    Result addToQueueTop(_AddToQueueTop value),
    Result addToQueueBottom(_AddToQueueBottom value),
    Result changeTrackPosition(_ChangeTrackPosition value),
    Result removeTrack(_RemoveTrack value),
    Result clearQueue(_ClearQueue value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (addToQueueTop != null) {
      return addToQueueTop(this);
    }
    return orElse();
  }
}

abstract class _AddToQueueTop implements QueueAction {
  const factory _AddToQueueTop({@required AudioTrack audioTrack}) =
      _$_AddToQueueTop;

  AudioTrack get audioTrack;
  _$AddToQueueTopCopyWith<_AddToQueueTop> get copyWith;
}

abstract class _$AddToQueueBottomCopyWith<$Res> {
  factory _$AddToQueueBottomCopyWith(
          _AddToQueueBottom value, $Res Function(_AddToQueueBottom) then) =
      __$AddToQueueBottomCopyWithImpl<$Res>;
  $Res call({AudioTrack audioTrack});
}

class __$AddToQueueBottomCopyWithImpl<$Res>
    extends _$QueueActionCopyWithImpl<$Res>
    implements _$AddToQueueBottomCopyWith<$Res> {
  __$AddToQueueBottomCopyWithImpl(
      _AddToQueueBottom _value, $Res Function(_AddToQueueBottom) _then)
      : super(_value, (v) => _then(v as _AddToQueueBottom));

  @override
  _AddToQueueBottom get _value => super._value as _AddToQueueBottom;

  @override
  $Res call({
    Object audioTrack = freezed,
  }) {
    return _then(_AddToQueueBottom(
      audioTrack:
          audioTrack == freezed ? _value.audioTrack : audioTrack as AudioTrack,
    ));
  }
}

class _$_AddToQueueBottom implements _AddToQueueBottom {
  const _$_AddToQueueBottom({@required this.audioTrack})
      : assert(audioTrack != null);

  @override
  final AudioTrack audioTrack;

  @override
  String toString() {
    return 'QueueAction.addToQueueBottom(audioTrack: $audioTrack)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _AddToQueueBottom &&
            (identical(other.audioTrack, audioTrack) ||
                const DeepCollectionEquality()
                    .equals(other.audioTrack, audioTrack)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(audioTrack);

  @override
  _$AddToQueueBottomCopyWith<_AddToQueueBottom> get copyWith =>
      __$AddToQueueBottomCopyWithImpl<_AddToQueueBottom>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result playTrack(AudioTrack audioTrack),
    @required Result playTrackAt(int position),
    @required Result addToQueueTop(AudioTrack audioTrack),
    @required Result addToQueueBottom(AudioTrack audioTrack),
    @required Result changeTrackPosition(int from, int to),
    @required Result removeTrack(int position),
    @required Result clearQueue(),
  }) {
    assert(playTrack != null);
    assert(playTrackAt != null);
    assert(addToQueueTop != null);
    assert(addToQueueBottom != null);
    assert(changeTrackPosition != null);
    assert(removeTrack != null);
    assert(clearQueue != null);
    return addToQueueBottom(audioTrack);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result playTrack(AudioTrack audioTrack),
    Result playTrackAt(int position),
    Result addToQueueTop(AudioTrack audioTrack),
    Result addToQueueBottom(AudioTrack audioTrack),
    Result changeTrackPosition(int from, int to),
    Result removeTrack(int position),
    Result clearQueue(),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (addToQueueBottom != null) {
      return addToQueueBottom(audioTrack);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result playTrack(_PlayTrack value),
    @required Result playTrackAt(_PlayTrackAt value),
    @required Result addToQueueTop(_AddToQueueTop value),
    @required Result addToQueueBottom(_AddToQueueBottom value),
    @required Result changeTrackPosition(_ChangeTrackPosition value),
    @required Result removeTrack(_RemoveTrack value),
    @required Result clearQueue(_ClearQueue value),
  }) {
    assert(playTrack != null);
    assert(playTrackAt != null);
    assert(addToQueueTop != null);
    assert(addToQueueBottom != null);
    assert(changeTrackPosition != null);
    assert(removeTrack != null);
    assert(clearQueue != null);
    return addToQueueBottom(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result playTrack(_PlayTrack value),
    Result playTrackAt(_PlayTrackAt value),
    Result addToQueueTop(_AddToQueueTop value),
    Result addToQueueBottom(_AddToQueueBottom value),
    Result changeTrackPosition(_ChangeTrackPosition value),
    Result removeTrack(_RemoveTrack value),
    Result clearQueue(_ClearQueue value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (addToQueueBottom != null) {
      return addToQueueBottom(this);
    }
    return orElse();
  }
}

abstract class _AddToQueueBottom implements QueueAction {
  const factory _AddToQueueBottom({@required AudioTrack audioTrack}) =
      _$_AddToQueueBottom;

  AudioTrack get audioTrack;
  _$AddToQueueBottomCopyWith<_AddToQueueBottom> get copyWith;
}

abstract class _$ChangeTrackPositionCopyWith<$Res> {
  factory _$ChangeTrackPositionCopyWith(_ChangeTrackPosition value,
          $Res Function(_ChangeTrackPosition) then) =
      __$ChangeTrackPositionCopyWithImpl<$Res>;
  $Res call({int from, int to});
}

class __$ChangeTrackPositionCopyWithImpl<$Res>
    extends _$QueueActionCopyWithImpl<$Res>
    implements _$ChangeTrackPositionCopyWith<$Res> {
  __$ChangeTrackPositionCopyWithImpl(
      _ChangeTrackPosition _value, $Res Function(_ChangeTrackPosition) _then)
      : super(_value, (v) => _then(v as _ChangeTrackPosition));

  @override
  _ChangeTrackPosition get _value => super._value as _ChangeTrackPosition;

  @override
  $Res call({
    Object from = freezed,
    Object to = freezed,
  }) {
    return _then(_ChangeTrackPosition(
      from: from == freezed ? _value.from : from as int,
      to: to == freezed ? _value.to : to as int,
    ));
  }
}

class _$_ChangeTrackPosition implements _ChangeTrackPosition {
  const _$_ChangeTrackPosition({@required this.from, @required this.to})
      : assert(from != null),
        assert(to != null);

  @override
  final int from;
  @override
  final int to;

  @override
  String toString() {
    return 'QueueAction.changeTrackPosition(from: $from, to: $to)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ChangeTrackPosition &&
            (identical(other.from, from) ||
                const DeepCollectionEquality().equals(other.from, from)) &&
            (identical(other.to, to) ||
                const DeepCollectionEquality().equals(other.to, to)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(from) ^
      const DeepCollectionEquality().hash(to);

  @override
  _$ChangeTrackPositionCopyWith<_ChangeTrackPosition> get copyWith =>
      __$ChangeTrackPositionCopyWithImpl<_ChangeTrackPosition>(
          this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result playTrack(AudioTrack audioTrack),
    @required Result playTrackAt(int position),
    @required Result addToQueueTop(AudioTrack audioTrack),
    @required Result addToQueueBottom(AudioTrack audioTrack),
    @required Result changeTrackPosition(int from, int to),
    @required Result removeTrack(int position),
    @required Result clearQueue(),
  }) {
    assert(playTrack != null);
    assert(playTrackAt != null);
    assert(addToQueueTop != null);
    assert(addToQueueBottom != null);
    assert(changeTrackPosition != null);
    assert(removeTrack != null);
    assert(clearQueue != null);
    return changeTrackPosition(from, to);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result playTrack(AudioTrack audioTrack),
    Result playTrackAt(int position),
    Result addToQueueTop(AudioTrack audioTrack),
    Result addToQueueBottom(AudioTrack audioTrack),
    Result changeTrackPosition(int from, int to),
    Result removeTrack(int position),
    Result clearQueue(),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (changeTrackPosition != null) {
      return changeTrackPosition(from, to);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result playTrack(_PlayTrack value),
    @required Result playTrackAt(_PlayTrackAt value),
    @required Result addToQueueTop(_AddToQueueTop value),
    @required Result addToQueueBottom(_AddToQueueBottom value),
    @required Result changeTrackPosition(_ChangeTrackPosition value),
    @required Result removeTrack(_RemoveTrack value),
    @required Result clearQueue(_ClearQueue value),
  }) {
    assert(playTrack != null);
    assert(playTrackAt != null);
    assert(addToQueueTop != null);
    assert(addToQueueBottom != null);
    assert(changeTrackPosition != null);
    assert(removeTrack != null);
    assert(clearQueue != null);
    return changeTrackPosition(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result playTrack(_PlayTrack value),
    Result playTrackAt(_PlayTrackAt value),
    Result addToQueueTop(_AddToQueueTop value),
    Result addToQueueBottom(_AddToQueueBottom value),
    Result changeTrackPosition(_ChangeTrackPosition value),
    Result removeTrack(_RemoveTrack value),
    Result clearQueue(_ClearQueue value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (changeTrackPosition != null) {
      return changeTrackPosition(this);
    }
    return orElse();
  }
}

abstract class _ChangeTrackPosition implements QueueAction {
  const factory _ChangeTrackPosition({@required int from, @required int to}) =
      _$_ChangeTrackPosition;

  int get from;
  int get to;
  _$ChangeTrackPositionCopyWith<_ChangeTrackPosition> get copyWith;
}

abstract class _$RemoveTrackCopyWith<$Res> {
  factory _$RemoveTrackCopyWith(
          _RemoveTrack value, $Res Function(_RemoveTrack) then) =
      __$RemoveTrackCopyWithImpl<$Res>;
  $Res call({int position});
}

class __$RemoveTrackCopyWithImpl<$Res> extends _$QueueActionCopyWithImpl<$Res>
    implements _$RemoveTrackCopyWith<$Res> {
  __$RemoveTrackCopyWithImpl(
      _RemoveTrack _value, $Res Function(_RemoveTrack) _then)
      : super(_value, (v) => _then(v as _RemoveTrack));

  @override
  _RemoveTrack get _value => super._value as _RemoveTrack;

  @override
  $Res call({
    Object position = freezed,
  }) {
    return _then(_RemoveTrack(
      position: position == freezed ? _value.position : position as int,
    ));
  }
}

class _$_RemoveTrack implements _RemoveTrack {
  const _$_RemoveTrack({@required this.position}) : assert(position != null);

  @override
  final int position;

  @override
  String toString() {
    return 'QueueAction.removeTrack(position: $position)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _RemoveTrack &&
            (identical(other.position, position) ||
                const DeepCollectionEquality()
                    .equals(other.position, position)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(position);

  @override
  _$RemoveTrackCopyWith<_RemoveTrack> get copyWith =>
      __$RemoveTrackCopyWithImpl<_RemoveTrack>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result playTrack(AudioTrack audioTrack),
    @required Result playTrackAt(int position),
    @required Result addToQueueTop(AudioTrack audioTrack),
    @required Result addToQueueBottom(AudioTrack audioTrack),
    @required Result changeTrackPosition(int from, int to),
    @required Result removeTrack(int position),
    @required Result clearQueue(),
  }) {
    assert(playTrack != null);
    assert(playTrackAt != null);
    assert(addToQueueTop != null);
    assert(addToQueueBottom != null);
    assert(changeTrackPosition != null);
    assert(removeTrack != null);
    assert(clearQueue != null);
    return removeTrack(position);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result playTrack(AudioTrack audioTrack),
    Result playTrackAt(int position),
    Result addToQueueTop(AudioTrack audioTrack),
    Result addToQueueBottom(AudioTrack audioTrack),
    Result changeTrackPosition(int from, int to),
    Result removeTrack(int position),
    Result clearQueue(),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (removeTrack != null) {
      return removeTrack(position);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result playTrack(_PlayTrack value),
    @required Result playTrackAt(_PlayTrackAt value),
    @required Result addToQueueTop(_AddToQueueTop value),
    @required Result addToQueueBottom(_AddToQueueBottom value),
    @required Result changeTrackPosition(_ChangeTrackPosition value),
    @required Result removeTrack(_RemoveTrack value),
    @required Result clearQueue(_ClearQueue value),
  }) {
    assert(playTrack != null);
    assert(playTrackAt != null);
    assert(addToQueueTop != null);
    assert(addToQueueBottom != null);
    assert(changeTrackPosition != null);
    assert(removeTrack != null);
    assert(clearQueue != null);
    return removeTrack(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result playTrack(_PlayTrack value),
    Result playTrackAt(_PlayTrackAt value),
    Result addToQueueTop(_AddToQueueTop value),
    Result addToQueueBottom(_AddToQueueBottom value),
    Result changeTrackPosition(_ChangeTrackPosition value),
    Result removeTrack(_RemoveTrack value),
    Result clearQueue(_ClearQueue value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (removeTrack != null) {
      return removeTrack(this);
    }
    return orElse();
  }
}

abstract class _RemoveTrack implements QueueAction {
  const factory _RemoveTrack({@required int position}) = _$_RemoveTrack;

  int get position;
  _$RemoveTrackCopyWith<_RemoveTrack> get copyWith;
}

abstract class _$ClearQueueCopyWith<$Res> {
  factory _$ClearQueueCopyWith(
          _ClearQueue value, $Res Function(_ClearQueue) then) =
      __$ClearQueueCopyWithImpl<$Res>;
}

class __$ClearQueueCopyWithImpl<$Res> extends _$QueueActionCopyWithImpl<$Res>
    implements _$ClearQueueCopyWith<$Res> {
  __$ClearQueueCopyWithImpl(
      _ClearQueue _value, $Res Function(_ClearQueue) _then)
      : super(_value, (v) => _then(v as _ClearQueue));

  @override
  _ClearQueue get _value => super._value as _ClearQueue;
}

class _$_ClearQueue implements _ClearQueue {
  const _$_ClearQueue();

  @override
  String toString() {
    return 'QueueAction.clearQueue()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _ClearQueue);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result playTrack(AudioTrack audioTrack),
    @required Result playTrackAt(int position),
    @required Result addToQueueTop(AudioTrack audioTrack),
    @required Result addToQueueBottom(AudioTrack audioTrack),
    @required Result changeTrackPosition(int from, int to),
    @required Result removeTrack(int position),
    @required Result clearQueue(),
  }) {
    assert(playTrack != null);
    assert(playTrackAt != null);
    assert(addToQueueTop != null);
    assert(addToQueueBottom != null);
    assert(changeTrackPosition != null);
    assert(removeTrack != null);
    assert(clearQueue != null);
    return clearQueue();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result playTrack(AudioTrack audioTrack),
    Result playTrackAt(int position),
    Result addToQueueTop(AudioTrack audioTrack),
    Result addToQueueBottom(AudioTrack audioTrack),
    Result changeTrackPosition(int from, int to),
    Result removeTrack(int position),
    Result clearQueue(),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (clearQueue != null) {
      return clearQueue();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result playTrack(_PlayTrack value),
    @required Result playTrackAt(_PlayTrackAt value),
    @required Result addToQueueTop(_AddToQueueTop value),
    @required Result addToQueueBottom(_AddToQueueBottom value),
    @required Result changeTrackPosition(_ChangeTrackPosition value),
    @required Result removeTrack(_RemoveTrack value),
    @required Result clearQueue(_ClearQueue value),
  }) {
    assert(playTrack != null);
    assert(playTrackAt != null);
    assert(addToQueueTop != null);
    assert(addToQueueBottom != null);
    assert(changeTrackPosition != null);
    assert(removeTrack != null);
    assert(clearQueue != null);
    return clearQueue(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result playTrack(_PlayTrack value),
    Result playTrackAt(_PlayTrackAt value),
    Result addToQueueTop(_AddToQueueTop value),
    Result addToQueueBottom(_AddToQueueBottom value),
    Result changeTrackPosition(_ChangeTrackPosition value),
    Result removeTrack(_RemoveTrack value),
    Result clearQueue(_ClearQueue value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (clearQueue != null) {
      return clearQueue(this);
    }
    return orElse();
  }
}

abstract class _ClearQueue implements QueueAction {
  const factory _ClearQueue() = _$_ClearQueue;
}

class _$AppEventTearOff {
  const _$AppEventTearOff();

// ignore: unused_element
  _SubscribeToPodcast subscribeToPodcast(
      {@required Podcast podcast, @required bool synced}) {
    return _SubscribeToPodcast(
      podcast: podcast,
      synced: synced,
    );
  }

// ignore: unused_element
  _UnsubscribeFromPodcast unsubscribeFromPodcast(
      {@required Podcast podcast, @required bool synced}) {
    return _UnsubscribeFromPodcast(
      podcast: podcast,
      synced: synced,
    );
  }
}

// ignore: unused_element
const $AppEvent = _$AppEventTearOff();

mixin _$AppEvent {
  Podcast get podcast;
  bool get synced;

  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result subscribeToPodcast(Podcast podcast, bool synced),
    @required Result unsubscribeFromPodcast(Podcast podcast, bool synced),
  });
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result subscribeToPodcast(Podcast podcast, bool synced),
    Result unsubscribeFromPodcast(Podcast podcast, bool synced),
    @required Result orElse(),
  });
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result subscribeToPodcast(_SubscribeToPodcast value),
    @required Result unsubscribeFromPodcast(_UnsubscribeFromPodcast value),
  });
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result subscribeToPodcast(_SubscribeToPodcast value),
    Result unsubscribeFromPodcast(_UnsubscribeFromPodcast value),
    @required Result orElse(),
  });

  $AppEventCopyWith<AppEvent> get copyWith;
}

abstract class $AppEventCopyWith<$Res> {
  factory $AppEventCopyWith(AppEvent value, $Res Function(AppEvent) then) =
      _$AppEventCopyWithImpl<$Res>;
  $Res call({Podcast podcast, bool synced});
}

class _$AppEventCopyWithImpl<$Res> implements $AppEventCopyWith<$Res> {
  _$AppEventCopyWithImpl(this._value, this._then);

  final AppEvent _value;
  // ignore: unused_field
  final $Res Function(AppEvent) _then;

  @override
  $Res call({
    Object podcast = freezed,
    Object synced = freezed,
  }) {
    return _then(_value.copyWith(
      podcast: podcast == freezed ? _value.podcast : podcast as Podcast,
      synced: synced == freezed ? _value.synced : synced as bool,
    ));
  }
}

abstract class _$SubscribeToPodcastCopyWith<$Res>
    implements $AppEventCopyWith<$Res> {
  factory _$SubscribeToPodcastCopyWith(
          _SubscribeToPodcast value, $Res Function(_SubscribeToPodcast) then) =
      __$SubscribeToPodcastCopyWithImpl<$Res>;
  @override
  $Res call({Podcast podcast, bool synced});
}

class __$SubscribeToPodcastCopyWithImpl<$Res>
    extends _$AppEventCopyWithImpl<$Res>
    implements _$SubscribeToPodcastCopyWith<$Res> {
  __$SubscribeToPodcastCopyWithImpl(
      _SubscribeToPodcast _value, $Res Function(_SubscribeToPodcast) _then)
      : super(_value, (v) => _then(v as _SubscribeToPodcast));

  @override
  _SubscribeToPodcast get _value => super._value as _SubscribeToPodcast;

  @override
  $Res call({
    Object podcast = freezed,
    Object synced = freezed,
  }) {
    return _then(_SubscribeToPodcast(
      podcast: podcast == freezed ? _value.podcast : podcast as Podcast,
      synced: synced == freezed ? _value.synced : synced as bool,
    ));
  }
}

class _$_SubscribeToPodcast implements _SubscribeToPodcast {
  const _$_SubscribeToPodcast({@required this.podcast, @required this.synced})
      : assert(podcast != null),
        assert(synced != null);

  @override
  final Podcast podcast;
  @override
  final bool synced;

  @override
  String toString() {
    return 'AppEvent.subscribeToPodcast(podcast: $podcast, synced: $synced)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _SubscribeToPodcast &&
            (identical(other.podcast, podcast) ||
                const DeepCollectionEquality()
                    .equals(other.podcast, podcast)) &&
            (identical(other.synced, synced) ||
                const DeepCollectionEquality().equals(other.synced, synced)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(podcast) ^
      const DeepCollectionEquality().hash(synced);

  @override
  _$SubscribeToPodcastCopyWith<_SubscribeToPodcast> get copyWith =>
      __$SubscribeToPodcastCopyWithImpl<_SubscribeToPodcast>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result subscribeToPodcast(Podcast podcast, bool synced),
    @required Result unsubscribeFromPodcast(Podcast podcast, bool synced),
  }) {
    assert(subscribeToPodcast != null);
    assert(unsubscribeFromPodcast != null);
    return subscribeToPodcast(podcast, synced);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result subscribeToPodcast(Podcast podcast, bool synced),
    Result unsubscribeFromPodcast(Podcast podcast, bool synced),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (subscribeToPodcast != null) {
      return subscribeToPodcast(podcast, synced);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result subscribeToPodcast(_SubscribeToPodcast value),
    @required Result unsubscribeFromPodcast(_UnsubscribeFromPodcast value),
  }) {
    assert(subscribeToPodcast != null);
    assert(unsubscribeFromPodcast != null);
    return subscribeToPodcast(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result subscribeToPodcast(_SubscribeToPodcast value),
    Result unsubscribeFromPodcast(_UnsubscribeFromPodcast value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (subscribeToPodcast != null) {
      return subscribeToPodcast(this);
    }
    return orElse();
  }
}

abstract class _SubscribeToPodcast implements AppEvent {
  const factory _SubscribeToPodcast(
      {@required Podcast podcast,
      @required bool synced}) = _$_SubscribeToPodcast;

  @override
  Podcast get podcast;
  @override
  bool get synced;
  @override
  _$SubscribeToPodcastCopyWith<_SubscribeToPodcast> get copyWith;
}

abstract class _$UnsubscribeFromPodcastCopyWith<$Res>
    implements $AppEventCopyWith<$Res> {
  factory _$UnsubscribeFromPodcastCopyWith(_UnsubscribeFromPodcast value,
          $Res Function(_UnsubscribeFromPodcast) then) =
      __$UnsubscribeFromPodcastCopyWithImpl<$Res>;
  @override
  $Res call({Podcast podcast, bool synced});
}

class __$UnsubscribeFromPodcastCopyWithImpl<$Res>
    extends _$AppEventCopyWithImpl<$Res>
    implements _$UnsubscribeFromPodcastCopyWith<$Res> {
  __$UnsubscribeFromPodcastCopyWithImpl(_UnsubscribeFromPodcast _value,
      $Res Function(_UnsubscribeFromPodcast) _then)
      : super(_value, (v) => _then(v as _UnsubscribeFromPodcast));

  @override
  _UnsubscribeFromPodcast get _value => super._value as _UnsubscribeFromPodcast;

  @override
  $Res call({
    Object podcast = freezed,
    Object synced = freezed,
  }) {
    return _then(_UnsubscribeFromPodcast(
      podcast: podcast == freezed ? _value.podcast : podcast as Podcast,
      synced: synced == freezed ? _value.synced : synced as bool,
    ));
  }
}

class _$_UnsubscribeFromPodcast implements _UnsubscribeFromPodcast {
  const _$_UnsubscribeFromPodcast(
      {@required this.podcast, @required this.synced})
      : assert(podcast != null),
        assert(synced != null);

  @override
  final Podcast podcast;
  @override
  final bool synced;

  @override
  String toString() {
    return 'AppEvent.unsubscribeFromPodcast(podcast: $podcast, synced: $synced)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _UnsubscribeFromPodcast &&
            (identical(other.podcast, podcast) ||
                const DeepCollectionEquality()
                    .equals(other.podcast, podcast)) &&
            (identical(other.synced, synced) ||
                const DeepCollectionEquality().equals(other.synced, synced)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(podcast) ^
      const DeepCollectionEquality().hash(synced);

  @override
  _$UnsubscribeFromPodcastCopyWith<_UnsubscribeFromPodcast> get copyWith =>
      __$UnsubscribeFromPodcastCopyWithImpl<_UnsubscribeFromPodcast>(
          this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result subscribeToPodcast(Podcast podcast, bool synced),
    @required Result unsubscribeFromPodcast(Podcast podcast, bool synced),
  }) {
    assert(subscribeToPodcast != null);
    assert(unsubscribeFromPodcast != null);
    return unsubscribeFromPodcast(podcast, synced);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result subscribeToPodcast(Podcast podcast, bool synced),
    Result unsubscribeFromPodcast(Podcast podcast, bool synced),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (unsubscribeFromPodcast != null) {
      return unsubscribeFromPodcast(podcast, synced);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result subscribeToPodcast(_SubscribeToPodcast value),
    @required Result unsubscribeFromPodcast(_UnsubscribeFromPodcast value),
  }) {
    assert(subscribeToPodcast != null);
    assert(unsubscribeFromPodcast != null);
    return unsubscribeFromPodcast(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result subscribeToPodcast(_SubscribeToPodcast value),
    Result unsubscribeFromPodcast(_UnsubscribeFromPodcast value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (unsubscribeFromPodcast != null) {
      return unsubscribeFromPodcast(this);
    }
    return orElse();
  }
}

abstract class _UnsubscribeFromPodcast implements AppEvent {
  const factory _UnsubscribeFromPodcast(
      {@required Podcast podcast,
      @required bool synced}) = _$_UnsubscribeFromPodcast;

  @override
  Podcast get podcast;
  @override
  bool get synced;
  @override
  _$UnsubscribeFromPodcastCopyWith<_UnsubscribeFromPodcast> get copyWith;
}

PreferenceValue _$PreferenceValueFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType'] as String) {
    case 'queueDetails':
      return QueueDetails.fromJson(json);
    case 'subscriptionsRefreshDetails':
      return SubscriptionsRefreshDetails.fromJson(json);
    case 'audioPlayerSetting':
      return AudioPlayerSetting.fromJson(json);
    case 'storageSetting':
      return StorageSetting.fromJson(json);

    default:
      throw FallThroughError();
  }
}

class _$PreferenceValueTearOff {
  const _$PreferenceValueTearOff();

// ignore: unused_element
  QueueDetails queueDetails({@required int position}) {
    return QueueDetails(
      position: position,
    );
  }

// ignore: unused_element
  SubscriptionsRefreshDetails subscriptionsRefreshDetails(
      {@required DateTime lastRefreshedAt}) {
    return SubscriptionsRefreshDetails(
      lastRefreshedAt: lastRefreshedAt,
    );
  }

// ignore: unused_element
  AudioPlayerSetting audioPlayerSetting(
      {@required int seekForwardTime, @required int seekBackwardTime}) {
    return AudioPlayerSetting(
      seekForwardTime: seekForwardTime,
      seekBackwardTime: seekBackwardTime,
    );
  }

// ignore: unused_element
  StorageSetting storageSetting(
      {@required Storage storage, @required String storagePath}) {
    return StorageSetting(
      storage: storage,
      storagePath: storagePath,
    );
  }
}

// ignore: unused_element
const $PreferenceValue = _$PreferenceValueTearOff();

mixin _$PreferenceValue {
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result queueDetails(int position),
    @required Result subscriptionsRefreshDetails(DateTime lastRefreshedAt),
    @required
        Result audioPlayerSetting(int seekForwardTime, int seekBackwardTime),
    @required Result storageSetting(Storage storage, String storagePath),
  });
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result queueDetails(int position),
    Result subscriptionsRefreshDetails(DateTime lastRefreshedAt),
    Result audioPlayerSetting(int seekForwardTime, int seekBackwardTime),
    Result storageSetting(Storage storage, String storagePath),
    @required Result orElse(),
  });
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result queueDetails(QueueDetails value),
    @required
        Result subscriptionsRefreshDetails(SubscriptionsRefreshDetails value),
    @required Result audioPlayerSetting(AudioPlayerSetting value),
    @required Result storageSetting(StorageSetting value),
  });
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result queueDetails(QueueDetails value),
    Result subscriptionsRefreshDetails(SubscriptionsRefreshDetails value),
    Result audioPlayerSetting(AudioPlayerSetting value),
    Result storageSetting(StorageSetting value),
    @required Result orElse(),
  });
  Map<String, dynamic> toJson();
}

abstract class $PreferenceValueCopyWith<$Res> {
  factory $PreferenceValueCopyWith(
          PreferenceValue value, $Res Function(PreferenceValue) then) =
      _$PreferenceValueCopyWithImpl<$Res>;
}

class _$PreferenceValueCopyWithImpl<$Res>
    implements $PreferenceValueCopyWith<$Res> {
  _$PreferenceValueCopyWithImpl(this._value, this._then);

  final PreferenceValue _value;
  // ignore: unused_field
  final $Res Function(PreferenceValue) _then;
}

abstract class $QueueDetailsCopyWith<$Res> {
  factory $QueueDetailsCopyWith(
          QueueDetails value, $Res Function(QueueDetails) then) =
      _$QueueDetailsCopyWithImpl<$Res>;
  $Res call({int position});
}

class _$QueueDetailsCopyWithImpl<$Res>
    extends _$PreferenceValueCopyWithImpl<$Res>
    implements $QueueDetailsCopyWith<$Res> {
  _$QueueDetailsCopyWithImpl(
      QueueDetails _value, $Res Function(QueueDetails) _then)
      : super(_value, (v) => _then(v as QueueDetails));

  @override
  QueueDetails get _value => super._value as QueueDetails;

  @override
  $Res call({
    Object position = freezed,
  }) {
    return _then(QueueDetails(
      position: position == freezed ? _value.position : position as int,
    ));
  }
}

@JsonSerializable()
class _$QueueDetails implements QueueDetails {
  const _$QueueDetails({@required this.position}) : assert(position != null);

  factory _$QueueDetails.fromJson(Map<String, dynamic> json) =>
      _$_$QueueDetailsFromJson(json);

  @override
  final int position;

  @override
  String toString() {
    return 'PreferenceValue.queueDetails(position: $position)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is QueueDetails &&
            (identical(other.position, position) ||
                const DeepCollectionEquality()
                    .equals(other.position, position)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(position);

  @override
  $QueueDetailsCopyWith<QueueDetails> get copyWith =>
      _$QueueDetailsCopyWithImpl<QueueDetails>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result queueDetails(int position),
    @required Result subscriptionsRefreshDetails(DateTime lastRefreshedAt),
    @required
        Result audioPlayerSetting(int seekForwardTime, int seekBackwardTime),
    @required Result storageSetting(Storage storage, String storagePath),
  }) {
    assert(queueDetails != null);
    assert(subscriptionsRefreshDetails != null);
    assert(audioPlayerSetting != null);
    assert(storageSetting != null);
    return queueDetails(position);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result queueDetails(int position),
    Result subscriptionsRefreshDetails(DateTime lastRefreshedAt),
    Result audioPlayerSetting(int seekForwardTime, int seekBackwardTime),
    Result storageSetting(Storage storage, String storagePath),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (queueDetails != null) {
      return queueDetails(position);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result queueDetails(QueueDetails value),
    @required
        Result subscriptionsRefreshDetails(SubscriptionsRefreshDetails value),
    @required Result audioPlayerSetting(AudioPlayerSetting value),
    @required Result storageSetting(StorageSetting value),
  }) {
    assert(queueDetails != null);
    assert(subscriptionsRefreshDetails != null);
    assert(audioPlayerSetting != null);
    assert(storageSetting != null);
    return queueDetails(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result queueDetails(QueueDetails value),
    Result subscriptionsRefreshDetails(SubscriptionsRefreshDetails value),
    Result audioPlayerSetting(AudioPlayerSetting value),
    Result storageSetting(StorageSetting value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (queueDetails != null) {
      return queueDetails(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$QueueDetailsToJson(this)..['runtimeType'] = 'queueDetails';
  }
}

abstract class QueueDetails implements PreferenceValue {
  const factory QueueDetails({@required int position}) = _$QueueDetails;

  factory QueueDetails.fromJson(Map<String, dynamic> json) =
      _$QueueDetails.fromJson;

  int get position;
  $QueueDetailsCopyWith<QueueDetails> get copyWith;
}

abstract class $SubscriptionsRefreshDetailsCopyWith<$Res> {
  factory $SubscriptionsRefreshDetailsCopyWith(
          SubscriptionsRefreshDetails value,
          $Res Function(SubscriptionsRefreshDetails) then) =
      _$SubscriptionsRefreshDetailsCopyWithImpl<$Res>;
  $Res call({DateTime lastRefreshedAt});
}

class _$SubscriptionsRefreshDetailsCopyWithImpl<$Res>
    extends _$PreferenceValueCopyWithImpl<$Res>
    implements $SubscriptionsRefreshDetailsCopyWith<$Res> {
  _$SubscriptionsRefreshDetailsCopyWithImpl(SubscriptionsRefreshDetails _value,
      $Res Function(SubscriptionsRefreshDetails) _then)
      : super(_value, (v) => _then(v as SubscriptionsRefreshDetails));

  @override
  SubscriptionsRefreshDetails get _value =>
      super._value as SubscriptionsRefreshDetails;

  @override
  $Res call({
    Object lastRefreshedAt = freezed,
  }) {
    return _then(SubscriptionsRefreshDetails(
      lastRefreshedAt: lastRefreshedAt == freezed
          ? _value.lastRefreshedAt
          : lastRefreshedAt as DateTime,
    ));
  }
}

@JsonSerializable()
class _$SubscriptionsRefreshDetails implements SubscriptionsRefreshDetails {
  const _$SubscriptionsRefreshDetails({@required this.lastRefreshedAt})
      : assert(lastRefreshedAt != null);

  factory _$SubscriptionsRefreshDetails.fromJson(Map<String, dynamic> json) =>
      _$_$SubscriptionsRefreshDetailsFromJson(json);

  @override
  final DateTime lastRefreshedAt;

  @override
  String toString() {
    return 'PreferenceValue.subscriptionsRefreshDetails(lastRefreshedAt: $lastRefreshedAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is SubscriptionsRefreshDetails &&
            (identical(other.lastRefreshedAt, lastRefreshedAt) ||
                const DeepCollectionEquality()
                    .equals(other.lastRefreshedAt, lastRefreshedAt)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(lastRefreshedAt);

  @override
  $SubscriptionsRefreshDetailsCopyWith<SubscriptionsRefreshDetails>
      get copyWith => _$SubscriptionsRefreshDetailsCopyWithImpl<
          SubscriptionsRefreshDetails>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result queueDetails(int position),
    @required Result subscriptionsRefreshDetails(DateTime lastRefreshedAt),
    @required
        Result audioPlayerSetting(int seekForwardTime, int seekBackwardTime),
    @required Result storageSetting(Storage storage, String storagePath),
  }) {
    assert(queueDetails != null);
    assert(subscriptionsRefreshDetails != null);
    assert(audioPlayerSetting != null);
    assert(storageSetting != null);
    return subscriptionsRefreshDetails(lastRefreshedAt);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result queueDetails(int position),
    Result subscriptionsRefreshDetails(DateTime lastRefreshedAt),
    Result audioPlayerSetting(int seekForwardTime, int seekBackwardTime),
    Result storageSetting(Storage storage, String storagePath),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (subscriptionsRefreshDetails != null) {
      return subscriptionsRefreshDetails(lastRefreshedAt);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result queueDetails(QueueDetails value),
    @required
        Result subscriptionsRefreshDetails(SubscriptionsRefreshDetails value),
    @required Result audioPlayerSetting(AudioPlayerSetting value),
    @required Result storageSetting(StorageSetting value),
  }) {
    assert(queueDetails != null);
    assert(subscriptionsRefreshDetails != null);
    assert(audioPlayerSetting != null);
    assert(storageSetting != null);
    return subscriptionsRefreshDetails(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result queueDetails(QueueDetails value),
    Result subscriptionsRefreshDetails(SubscriptionsRefreshDetails value),
    Result audioPlayerSetting(AudioPlayerSetting value),
    Result storageSetting(StorageSetting value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (subscriptionsRefreshDetails != null) {
      return subscriptionsRefreshDetails(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$SubscriptionsRefreshDetailsToJson(this)
      ..['runtimeType'] = 'subscriptionsRefreshDetails';
  }
}

abstract class SubscriptionsRefreshDetails implements PreferenceValue {
  const factory SubscriptionsRefreshDetails(
      {@required DateTime lastRefreshedAt}) = _$SubscriptionsRefreshDetails;

  factory SubscriptionsRefreshDetails.fromJson(Map<String, dynamic> json) =
      _$SubscriptionsRefreshDetails.fromJson;

  DateTime get lastRefreshedAt;
  $SubscriptionsRefreshDetailsCopyWith<SubscriptionsRefreshDetails>
      get copyWith;
}

abstract class $AudioPlayerSettingCopyWith<$Res> {
  factory $AudioPlayerSettingCopyWith(
          AudioPlayerSetting value, $Res Function(AudioPlayerSetting) then) =
      _$AudioPlayerSettingCopyWithImpl<$Res>;
  $Res call({int seekForwardTime, int seekBackwardTime});
}

class _$AudioPlayerSettingCopyWithImpl<$Res>
    extends _$PreferenceValueCopyWithImpl<$Res>
    implements $AudioPlayerSettingCopyWith<$Res> {
  _$AudioPlayerSettingCopyWithImpl(
      AudioPlayerSetting _value, $Res Function(AudioPlayerSetting) _then)
      : super(_value, (v) => _then(v as AudioPlayerSetting));

  @override
  AudioPlayerSetting get _value => super._value as AudioPlayerSetting;

  @override
  $Res call({
    Object seekForwardTime = freezed,
    Object seekBackwardTime = freezed,
  }) {
    return _then(AudioPlayerSetting(
      seekForwardTime: seekForwardTime == freezed
          ? _value.seekForwardTime
          : seekForwardTime as int,
      seekBackwardTime: seekBackwardTime == freezed
          ? _value.seekBackwardTime
          : seekBackwardTime as int,
    ));
  }
}

@JsonSerializable()
class _$AudioPlayerSetting implements AudioPlayerSetting {
  const _$AudioPlayerSetting(
      {@required this.seekForwardTime, @required this.seekBackwardTime})
      : assert(seekForwardTime != null),
        assert(seekBackwardTime != null);

  factory _$AudioPlayerSetting.fromJson(Map<String, dynamic> json) =>
      _$_$AudioPlayerSettingFromJson(json);

  @override
  final int seekForwardTime;
  @override
  final int seekBackwardTime;

  @override
  String toString() {
    return 'PreferenceValue.audioPlayerSetting(seekForwardTime: $seekForwardTime, seekBackwardTime: $seekBackwardTime)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AudioPlayerSetting &&
            (identical(other.seekForwardTime, seekForwardTime) ||
                const DeepCollectionEquality()
                    .equals(other.seekForwardTime, seekForwardTime)) &&
            (identical(other.seekBackwardTime, seekBackwardTime) ||
                const DeepCollectionEquality()
                    .equals(other.seekBackwardTime, seekBackwardTime)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(seekForwardTime) ^
      const DeepCollectionEquality().hash(seekBackwardTime);

  @override
  $AudioPlayerSettingCopyWith<AudioPlayerSetting> get copyWith =>
      _$AudioPlayerSettingCopyWithImpl<AudioPlayerSetting>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result queueDetails(int position),
    @required Result subscriptionsRefreshDetails(DateTime lastRefreshedAt),
    @required
        Result audioPlayerSetting(int seekForwardTime, int seekBackwardTime),
    @required Result storageSetting(Storage storage, String storagePath),
  }) {
    assert(queueDetails != null);
    assert(subscriptionsRefreshDetails != null);
    assert(audioPlayerSetting != null);
    assert(storageSetting != null);
    return audioPlayerSetting(seekForwardTime, seekBackwardTime);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result queueDetails(int position),
    Result subscriptionsRefreshDetails(DateTime lastRefreshedAt),
    Result audioPlayerSetting(int seekForwardTime, int seekBackwardTime),
    Result storageSetting(Storage storage, String storagePath),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (audioPlayerSetting != null) {
      return audioPlayerSetting(seekForwardTime, seekBackwardTime);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result queueDetails(QueueDetails value),
    @required
        Result subscriptionsRefreshDetails(SubscriptionsRefreshDetails value),
    @required Result audioPlayerSetting(AudioPlayerSetting value),
    @required Result storageSetting(StorageSetting value),
  }) {
    assert(queueDetails != null);
    assert(subscriptionsRefreshDetails != null);
    assert(audioPlayerSetting != null);
    assert(storageSetting != null);
    return audioPlayerSetting(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result queueDetails(QueueDetails value),
    Result subscriptionsRefreshDetails(SubscriptionsRefreshDetails value),
    Result audioPlayerSetting(AudioPlayerSetting value),
    Result storageSetting(StorageSetting value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (audioPlayerSetting != null) {
      return audioPlayerSetting(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$AudioPlayerSettingToJson(this)
      ..['runtimeType'] = 'audioPlayerSetting';
  }
}

abstract class AudioPlayerSetting implements PreferenceValue {
  const factory AudioPlayerSetting(
      {@required int seekForwardTime,
      @required int seekBackwardTime}) = _$AudioPlayerSetting;

  factory AudioPlayerSetting.fromJson(Map<String, dynamic> json) =
      _$AudioPlayerSetting.fromJson;

  int get seekForwardTime;
  int get seekBackwardTime;
  $AudioPlayerSettingCopyWith<AudioPlayerSetting> get copyWith;
}

abstract class $StorageSettingCopyWith<$Res> {
  factory $StorageSettingCopyWith(
          StorageSetting value, $Res Function(StorageSetting) then) =
      _$StorageSettingCopyWithImpl<$Res>;
  $Res call({Storage storage, String storagePath});
}

class _$StorageSettingCopyWithImpl<$Res>
    extends _$PreferenceValueCopyWithImpl<$Res>
    implements $StorageSettingCopyWith<$Res> {
  _$StorageSettingCopyWithImpl(
      StorageSetting _value, $Res Function(StorageSetting) _then)
      : super(_value, (v) => _then(v as StorageSetting));

  @override
  StorageSetting get _value => super._value as StorageSetting;

  @override
  $Res call({
    Object storage = freezed,
    Object storagePath = freezed,
  }) {
    return _then(StorageSetting(
      storage: storage == freezed ? _value.storage : storage as Storage,
      storagePath:
          storagePath == freezed ? _value.storagePath : storagePath as String,
    ));
  }
}

@JsonSerializable()
class _$StorageSetting implements StorageSetting {
  const _$StorageSetting({@required this.storage, @required this.storagePath})
      : assert(storage != null),
        assert(storagePath != null);

  factory _$StorageSetting.fromJson(Map<String, dynamic> json) =>
      _$_$StorageSettingFromJson(json);

  @override
  final Storage storage;
  @override
  final String storagePath;

  @override
  String toString() {
    return 'PreferenceValue.storageSetting(storage: $storage, storagePath: $storagePath)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is StorageSetting &&
            (identical(other.storage, storage) ||
                const DeepCollectionEquality()
                    .equals(other.storage, storage)) &&
            (identical(other.storagePath, storagePath) ||
                const DeepCollectionEquality()
                    .equals(other.storagePath, storagePath)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(storage) ^
      const DeepCollectionEquality().hash(storagePath);

  @override
  $StorageSettingCopyWith<StorageSetting> get copyWith =>
      _$StorageSettingCopyWithImpl<StorageSetting>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result queueDetails(int position),
    @required Result subscriptionsRefreshDetails(DateTime lastRefreshedAt),
    @required
        Result audioPlayerSetting(int seekForwardTime, int seekBackwardTime),
    @required Result storageSetting(Storage storage, String storagePath),
  }) {
    assert(queueDetails != null);
    assert(subscriptionsRefreshDetails != null);
    assert(audioPlayerSetting != null);
    assert(storageSetting != null);
    return storageSetting(storage, storagePath);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result queueDetails(int position),
    Result subscriptionsRefreshDetails(DateTime lastRefreshedAt),
    Result audioPlayerSetting(int seekForwardTime, int seekBackwardTime),
    Result storageSetting(Storage storage, String storagePath),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (storageSetting != null) {
      return storageSetting(storage, storagePath);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result queueDetails(QueueDetails value),
    @required
        Result subscriptionsRefreshDetails(SubscriptionsRefreshDetails value),
    @required Result audioPlayerSetting(AudioPlayerSetting value),
    @required Result storageSetting(StorageSetting value),
  }) {
    assert(queueDetails != null);
    assert(subscriptionsRefreshDetails != null);
    assert(audioPlayerSetting != null);
    assert(storageSetting != null);
    return storageSetting(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result queueDetails(QueueDetails value),
    Result subscriptionsRefreshDetails(SubscriptionsRefreshDetails value),
    Result audioPlayerSetting(AudioPlayerSetting value),
    Result storageSetting(StorageSetting value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (storageSetting != null) {
      return storageSetting(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$StorageSettingToJson(this)..['runtimeType'] = 'storageSetting';
  }
}

abstract class StorageSetting implements PreferenceValue {
  const factory StorageSetting(
      {@required Storage storage,
      @required String storagePath}) = _$StorageSetting;

  factory StorageSetting.fromJson(Map<String, dynamic> json) =
      _$StorageSetting.fromJson;

  Storage get storage;
  String get storagePath;
  $StorageSettingCopyWith<StorageSetting> get copyWith;
}

class _$AppScreenTearOff {
  const _$AppScreenTearOff();

// ignore: unused_element
  _PodcastScreen podcastScreen(
      {@required String urlParam,
      @required String title,
      @required String author,
      bool isSubscribed = false}) {
    return _PodcastScreen(
      urlParam: urlParam,
      title: title,
      author: author,
      isSubscribed: isSubscribed,
    );
  }

// ignore: unused_element
  _DownloadsScreen downloadsScreen() {
    return const _DownloadsScreen();
  }
}

// ignore: unused_element
const $AppScreen = _$AppScreenTearOff();

mixin _$AppScreen {
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required
        Result podcastScreen(
            String urlParam, String title, String author, bool isSubscribed),
    @required Result downloadsScreen(),
  });
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result podcastScreen(
        String urlParam, String title, String author, bool isSubscribed),
    Result downloadsScreen(),
    @required Result orElse(),
  });
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result podcastScreen(_PodcastScreen value),
    @required Result downloadsScreen(_DownloadsScreen value),
  });
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result podcastScreen(_PodcastScreen value),
    Result downloadsScreen(_DownloadsScreen value),
    @required Result orElse(),
  });
}

abstract class $AppScreenCopyWith<$Res> {
  factory $AppScreenCopyWith(AppScreen value, $Res Function(AppScreen) then) =
      _$AppScreenCopyWithImpl<$Res>;
}

class _$AppScreenCopyWithImpl<$Res> implements $AppScreenCopyWith<$Res> {
  _$AppScreenCopyWithImpl(this._value, this._then);

  final AppScreen _value;
  // ignore: unused_field
  final $Res Function(AppScreen) _then;
}

abstract class _$PodcastScreenCopyWith<$Res> {
  factory _$PodcastScreenCopyWith(
          _PodcastScreen value, $Res Function(_PodcastScreen) then) =
      __$PodcastScreenCopyWithImpl<$Res>;
  $Res call({String urlParam, String title, String author, bool isSubscribed});
}

class __$PodcastScreenCopyWithImpl<$Res> extends _$AppScreenCopyWithImpl<$Res>
    implements _$PodcastScreenCopyWith<$Res> {
  __$PodcastScreenCopyWithImpl(
      _PodcastScreen _value, $Res Function(_PodcastScreen) _then)
      : super(_value, (v) => _then(v as _PodcastScreen));

  @override
  _PodcastScreen get _value => super._value as _PodcastScreen;

  @override
  $Res call({
    Object urlParam = freezed,
    Object title = freezed,
    Object author = freezed,
    Object isSubscribed = freezed,
  }) {
    return _then(_PodcastScreen(
      urlParam: urlParam == freezed ? _value.urlParam : urlParam as String,
      title: title == freezed ? _value.title : title as String,
      author: author == freezed ? _value.author : author as String,
      isSubscribed:
          isSubscribed == freezed ? _value.isSubscribed : isSubscribed as bool,
    ));
  }
}

class _$_PodcastScreen implements _PodcastScreen {
  const _$_PodcastScreen(
      {@required this.urlParam,
      @required this.title,
      @required this.author,
      this.isSubscribed = false})
      : assert(urlParam != null),
        assert(title != null),
        assert(author != null),
        assert(isSubscribed != null);

  @override
  final String urlParam;
  @override
  final String title;
  @override
  final String author;
  @JsonKey(defaultValue: false)
  @override
  final bool isSubscribed;

  @override
  String toString() {
    return 'AppScreen.podcastScreen(urlParam: $urlParam, title: $title, author: $author, isSubscribed: $isSubscribed)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _PodcastScreen &&
            (identical(other.urlParam, urlParam) ||
                const DeepCollectionEquality()
                    .equals(other.urlParam, urlParam)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.author, author) ||
                const DeepCollectionEquality().equals(other.author, author)) &&
            (identical(other.isSubscribed, isSubscribed) ||
                const DeepCollectionEquality()
                    .equals(other.isSubscribed, isSubscribed)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(urlParam) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(author) ^
      const DeepCollectionEquality().hash(isSubscribed);

  @override
  _$PodcastScreenCopyWith<_PodcastScreen> get copyWith =>
      __$PodcastScreenCopyWithImpl<_PodcastScreen>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required
        Result podcastScreen(
            String urlParam, String title, String author, bool isSubscribed),
    @required Result downloadsScreen(),
  }) {
    assert(podcastScreen != null);
    assert(downloadsScreen != null);
    return podcastScreen(urlParam, title, author, isSubscribed);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result podcastScreen(
        String urlParam, String title, String author, bool isSubscribed),
    Result downloadsScreen(),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (podcastScreen != null) {
      return podcastScreen(urlParam, title, author, isSubscribed);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result podcastScreen(_PodcastScreen value),
    @required Result downloadsScreen(_DownloadsScreen value),
  }) {
    assert(podcastScreen != null);
    assert(downloadsScreen != null);
    return podcastScreen(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result podcastScreen(_PodcastScreen value),
    Result downloadsScreen(_DownloadsScreen value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (podcastScreen != null) {
      return podcastScreen(this);
    }
    return orElse();
  }
}

abstract class _PodcastScreen implements AppScreen {
  const factory _PodcastScreen(
      {@required String urlParam,
      @required String title,
      @required String author,
      bool isSubscribed}) = _$_PodcastScreen;

  String get urlParam;
  String get title;
  String get author;
  bool get isSubscribed;
  _$PodcastScreenCopyWith<_PodcastScreen> get copyWith;
}

abstract class _$DownloadsScreenCopyWith<$Res> {
  factory _$DownloadsScreenCopyWith(
          _DownloadsScreen value, $Res Function(_DownloadsScreen) then) =
      __$DownloadsScreenCopyWithImpl<$Res>;
}

class __$DownloadsScreenCopyWithImpl<$Res> extends _$AppScreenCopyWithImpl<$Res>
    implements _$DownloadsScreenCopyWith<$Res> {
  __$DownloadsScreenCopyWithImpl(
      _DownloadsScreen _value, $Res Function(_DownloadsScreen) _then)
      : super(_value, (v) => _then(v as _DownloadsScreen));

  @override
  _DownloadsScreen get _value => super._value as _DownloadsScreen;
}

class _$_DownloadsScreen implements _DownloadsScreen {
  const _$_DownloadsScreen();

  @override
  String toString() {
    return 'AppScreen.downloadsScreen()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _DownloadsScreen);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required
        Result podcastScreen(
            String urlParam, String title, String author, bool isSubscribed),
    @required Result downloadsScreen(),
  }) {
    assert(podcastScreen != null);
    assert(downloadsScreen != null);
    return downloadsScreen();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result podcastScreen(
        String urlParam, String title, String author, bool isSubscribed),
    Result downloadsScreen(),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (downloadsScreen != null) {
      return downloadsScreen();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result podcastScreen(_PodcastScreen value),
    @required Result downloadsScreen(_DownloadsScreen value),
  }) {
    assert(podcastScreen != null);
    assert(downloadsScreen != null);
    return downloadsScreen(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result podcastScreen(_PodcastScreen value),
    Result downloadsScreen(_DownloadsScreen value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (downloadsScreen != null) {
      return downloadsScreen(this);
    }
    return orElse();
  }
}

abstract class _DownloadsScreen implements AppScreen {
  const factory _DownloadsScreen() = _$_DownloadsScreen;
}

TaskType _$TaskTypeFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType'] as String) {
    case 'cachePodcast':
      return _CachePodcast.fromJson(json);
    case 'downloadEpisode':
      return _DownloadEpisode.fromJson(json);

    default:
      throw FallThroughError();
  }
}

class _$TaskTypeTearOff {
  const _$TaskTypeTearOff();

// ignore: unused_element
  _CachePodcast cachePodcast(
      {@required String podcastId, @required String podcastUrlParam}) {
    return _CachePodcast(
      podcastId: podcastId,
      podcastUrlParam: podcastUrlParam,
    );
  }

// ignore: unused_element
  _DownloadEpisode downloadEpisode(
      {@required String episodeId,
      @required String url,
      @required String filename,
      @required String storagePath}) {
    return _DownloadEpisode(
      episodeId: episodeId,
      url: url,
      filename: filename,
      storagePath: storagePath,
    );
  }
}

// ignore: unused_element
const $TaskType = _$TaskTypeTearOff();

mixin _$TaskType {
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result cachePodcast(String podcastId, String podcastUrlParam),
    @required
        Result downloadEpisode(
            String episodeId, String url, String filename, String storagePath),
  });
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result cachePodcast(String podcastId, String podcastUrlParam),
    Result downloadEpisode(
        String episodeId, String url, String filename, String storagePath),
    @required Result orElse(),
  });
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result cachePodcast(_CachePodcast value),
    @required Result downloadEpisode(_DownloadEpisode value),
  });
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result cachePodcast(_CachePodcast value),
    Result downloadEpisode(_DownloadEpisode value),
    @required Result orElse(),
  });
  Map<String, dynamic> toJson();
}

abstract class $TaskTypeCopyWith<$Res> {
  factory $TaskTypeCopyWith(TaskType value, $Res Function(TaskType) then) =
      _$TaskTypeCopyWithImpl<$Res>;
}

class _$TaskTypeCopyWithImpl<$Res> implements $TaskTypeCopyWith<$Res> {
  _$TaskTypeCopyWithImpl(this._value, this._then);

  final TaskType _value;
  // ignore: unused_field
  final $Res Function(TaskType) _then;
}

abstract class _$CachePodcastCopyWith<$Res> {
  factory _$CachePodcastCopyWith(
          _CachePodcast value, $Res Function(_CachePodcast) then) =
      __$CachePodcastCopyWithImpl<$Res>;
  $Res call({String podcastId, String podcastUrlParam});
}

class __$CachePodcastCopyWithImpl<$Res> extends _$TaskTypeCopyWithImpl<$Res>
    implements _$CachePodcastCopyWith<$Res> {
  __$CachePodcastCopyWithImpl(
      _CachePodcast _value, $Res Function(_CachePodcast) _then)
      : super(_value, (v) => _then(v as _CachePodcast));

  @override
  _CachePodcast get _value => super._value as _CachePodcast;

  @override
  $Res call({
    Object podcastId = freezed,
    Object podcastUrlParam = freezed,
  }) {
    return _then(_CachePodcast(
      podcastId: podcastId == freezed ? _value.podcastId : podcastId as String,
      podcastUrlParam: podcastUrlParam == freezed
          ? _value.podcastUrlParam
          : podcastUrlParam as String,
    ));
  }
}

@JsonSerializable()
class _$_CachePodcast implements _CachePodcast {
  const _$_CachePodcast(
      {@required this.podcastId, @required this.podcastUrlParam})
      : assert(podcastId != null),
        assert(podcastUrlParam != null);

  factory _$_CachePodcast.fromJson(Map<String, dynamic> json) =>
      _$_$_CachePodcastFromJson(json);

  @override
  final String podcastId;
  @override
  final String podcastUrlParam;

  @override
  String toString() {
    return 'TaskType.cachePodcast(podcastId: $podcastId, podcastUrlParam: $podcastUrlParam)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _CachePodcast &&
            (identical(other.podcastId, podcastId) ||
                const DeepCollectionEquality()
                    .equals(other.podcastId, podcastId)) &&
            (identical(other.podcastUrlParam, podcastUrlParam) ||
                const DeepCollectionEquality()
                    .equals(other.podcastUrlParam, podcastUrlParam)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(podcastId) ^
      const DeepCollectionEquality().hash(podcastUrlParam);

  @override
  _$CachePodcastCopyWith<_CachePodcast> get copyWith =>
      __$CachePodcastCopyWithImpl<_CachePodcast>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result cachePodcast(String podcastId, String podcastUrlParam),
    @required
        Result downloadEpisode(
            String episodeId, String url, String filename, String storagePath),
  }) {
    assert(cachePodcast != null);
    assert(downloadEpisode != null);
    return cachePodcast(podcastId, podcastUrlParam);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result cachePodcast(String podcastId, String podcastUrlParam),
    Result downloadEpisode(
        String episodeId, String url, String filename, String storagePath),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (cachePodcast != null) {
      return cachePodcast(podcastId, podcastUrlParam);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result cachePodcast(_CachePodcast value),
    @required Result downloadEpisode(_DownloadEpisode value),
  }) {
    assert(cachePodcast != null);
    assert(downloadEpisode != null);
    return cachePodcast(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result cachePodcast(_CachePodcast value),
    Result downloadEpisode(_DownloadEpisode value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (cachePodcast != null) {
      return cachePodcast(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$_CachePodcastToJson(this)..['runtimeType'] = 'cachePodcast';
  }
}

abstract class _CachePodcast implements TaskType {
  const factory _CachePodcast(
      {@required String podcastId,
      @required String podcastUrlParam}) = _$_CachePodcast;

  factory _CachePodcast.fromJson(Map<String, dynamic> json) =
      _$_CachePodcast.fromJson;

  String get podcastId;
  String get podcastUrlParam;
  _$CachePodcastCopyWith<_CachePodcast> get copyWith;
}

abstract class _$DownloadEpisodeCopyWith<$Res> {
  factory _$DownloadEpisodeCopyWith(
          _DownloadEpisode value, $Res Function(_DownloadEpisode) then) =
      __$DownloadEpisodeCopyWithImpl<$Res>;
  $Res call(
      {String episodeId, String url, String filename, String storagePath});
}

class __$DownloadEpisodeCopyWithImpl<$Res> extends _$TaskTypeCopyWithImpl<$Res>
    implements _$DownloadEpisodeCopyWith<$Res> {
  __$DownloadEpisodeCopyWithImpl(
      _DownloadEpisode _value, $Res Function(_DownloadEpisode) _then)
      : super(_value, (v) => _then(v as _DownloadEpisode));

  @override
  _DownloadEpisode get _value => super._value as _DownloadEpisode;

  @override
  $Res call({
    Object episodeId = freezed,
    Object url = freezed,
    Object filename = freezed,
    Object storagePath = freezed,
  }) {
    return _then(_DownloadEpisode(
      episodeId: episodeId == freezed ? _value.episodeId : episodeId as String,
      url: url == freezed ? _value.url : url as String,
      filename: filename == freezed ? _value.filename : filename as String,
      storagePath:
          storagePath == freezed ? _value.storagePath : storagePath as String,
    ));
  }
}

@JsonSerializable()
class _$_DownloadEpisode implements _DownloadEpisode {
  const _$_DownloadEpisode(
      {@required this.episodeId,
      @required this.url,
      @required this.filename,
      @required this.storagePath})
      : assert(episodeId != null),
        assert(url != null),
        assert(filename != null),
        assert(storagePath != null);

  factory _$_DownloadEpisode.fromJson(Map<String, dynamic> json) =>
      _$_$_DownloadEpisodeFromJson(json);

  @override
  final String episodeId;
  @override
  final String url;
  @override
  final String filename;
  @override
  final String storagePath;

  @override
  String toString() {
    return 'TaskType.downloadEpisode(episodeId: $episodeId, url: $url, filename: $filename, storagePath: $storagePath)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _DownloadEpisode &&
            (identical(other.episodeId, episodeId) ||
                const DeepCollectionEquality()
                    .equals(other.episodeId, episodeId)) &&
            (identical(other.url, url) ||
                const DeepCollectionEquality().equals(other.url, url)) &&
            (identical(other.filename, filename) ||
                const DeepCollectionEquality()
                    .equals(other.filename, filename)) &&
            (identical(other.storagePath, storagePath) ||
                const DeepCollectionEquality()
                    .equals(other.storagePath, storagePath)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(episodeId) ^
      const DeepCollectionEquality().hash(url) ^
      const DeepCollectionEquality().hash(filename) ^
      const DeepCollectionEquality().hash(storagePath);

  @override
  _$DownloadEpisodeCopyWith<_DownloadEpisode> get copyWith =>
      __$DownloadEpisodeCopyWithImpl<_DownloadEpisode>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result cachePodcast(String podcastId, String podcastUrlParam),
    @required
        Result downloadEpisode(
            String episodeId, String url, String filename, String storagePath),
  }) {
    assert(cachePodcast != null);
    assert(downloadEpisode != null);
    return downloadEpisode(episodeId, url, filename, storagePath);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result cachePodcast(String podcastId, String podcastUrlParam),
    Result downloadEpisode(
        String episodeId, String url, String filename, String storagePath),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (downloadEpisode != null) {
      return downloadEpisode(episodeId, url, filename, storagePath);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result cachePodcast(_CachePodcast value),
    @required Result downloadEpisode(_DownloadEpisode value),
  }) {
    assert(cachePodcast != null);
    assert(downloadEpisode != null);
    return downloadEpisode(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result cachePodcast(_CachePodcast value),
    Result downloadEpisode(_DownloadEpisode value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (downloadEpisode != null) {
      return downloadEpisode(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$_$_DownloadEpisodeToJson(this)
      ..['runtimeType'] = 'downloadEpisode';
  }
}

abstract class _DownloadEpisode implements TaskType {
  const factory _DownloadEpisode(
      {@required String episodeId,
      @required String url,
      @required String filename,
      @required String storagePath}) = _$_DownloadEpisode;

  factory _DownloadEpisode.fromJson(Map<String, dynamic> json) =
      _$_DownloadEpisode.fromJson;

  String get episodeId;
  String get url;
  String get filename;
  String get storagePath;
  _$DownloadEpisodeCopyWith<_DownloadEpisode> get copyWith;
}
