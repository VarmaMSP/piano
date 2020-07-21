// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'task.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
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
class _$_CachePodcast with DiagnosticableTreeMixin implements _CachePodcast {
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
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TaskType.cachePodcast(podcastId: $podcastId, podcastUrlParam: $podcastUrlParam)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TaskType.cachePodcast'))
      ..add(DiagnosticsProperty('podcastId', podcastId))
      ..add(DiagnosticsProperty('podcastUrlParam', podcastUrlParam));
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
class _$_DownloadEpisode
    with DiagnosticableTreeMixin
    implements _DownloadEpisode {
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
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TaskType.downloadEpisode(episodeId: $episodeId, url: $url, filename: $filename, storagePath: $storagePath)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TaskType.downloadEpisode'))
      ..add(DiagnosticsProperty('episodeId', episodeId))
      ..add(DiagnosticsProperty('url', url))
      ..add(DiagnosticsProperty('filename', filename))
      ..add(DiagnosticsProperty('storagePath', storagePath));
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
