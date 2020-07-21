// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'preference.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
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
class _$QueueDetails with DiagnosticableTreeMixin implements QueueDetails {
  const _$QueueDetails({@required this.position}) : assert(position != null);

  factory _$QueueDetails.fromJson(Map<String, dynamic> json) =>
      _$_$QueueDetailsFromJson(json);

  @override
  final int position;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PreferenceValue.queueDetails(position: $position)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PreferenceValue.queueDetails'))
      ..add(DiagnosticsProperty('position', position));
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
class _$SubscriptionsRefreshDetails
    with DiagnosticableTreeMixin
    implements SubscriptionsRefreshDetails {
  const _$SubscriptionsRefreshDetails({@required this.lastRefreshedAt})
      : assert(lastRefreshedAt != null);

  factory _$SubscriptionsRefreshDetails.fromJson(Map<String, dynamic> json) =>
      _$_$SubscriptionsRefreshDetailsFromJson(json);

  @override
  final DateTime lastRefreshedAt;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PreferenceValue.subscriptionsRefreshDetails(lastRefreshedAt: $lastRefreshedAt)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty(
          'type', 'PreferenceValue.subscriptionsRefreshDetails'))
      ..add(DiagnosticsProperty('lastRefreshedAt', lastRefreshedAt));
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
class _$AudioPlayerSetting
    with DiagnosticableTreeMixin
    implements AudioPlayerSetting {
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
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PreferenceValue.audioPlayerSetting(seekForwardTime: $seekForwardTime, seekBackwardTime: $seekBackwardTime)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PreferenceValue.audioPlayerSetting'))
      ..add(DiagnosticsProperty('seekForwardTime', seekForwardTime))
      ..add(DiagnosticsProperty('seekBackwardTime', seekBackwardTime));
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
class _$StorageSetting with DiagnosticableTreeMixin implements StorageSetting {
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
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PreferenceValue.storageSetting(storage: $storage, storagePath: $storagePath)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PreferenceValue.storageSetting'))
      ..add(DiagnosticsProperty('storage', storage))
      ..add(DiagnosticsProperty('storagePath', storagePath));
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
