// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unnecessary_this, return_of_invalid_type, constant_identifier_names, prefer_const_constructors_in_immutables, sort_unnamed_constructors_first, join_return_with_assignment

part of 'preference.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension AudioPlayerSettingCopyWithExtension on AudioPlayerSetting {
  AudioPlayerSetting copyWith({
    int seekBackwardTime,
    int seekForwardTime,
  }) {
    return AudioPlayerSetting(
      seekBackwardTime: seekBackwardTime ?? this.seekBackwardTime,
      seekForwardTime: seekForwardTime ?? this.seekForwardTime,
    );
  }
}

extension StorageSettingCopyWithExtension on StorageSetting {
  StorageSetting copyWith({
    Storage storage,
  }) {
    return StorageSetting(
      storage: storage ?? this.storage,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PreferenceValue _$PreferenceValueFromJson(Map<String, dynamic> json) {
  return PreferenceValue(
    queueDetails: json['queue_details'] == null
        ? null
        : QueueDetails.fromJson(json['queue_details'] as Map<String, dynamic>),
    audioPlayerSetting: json['audio_player_setting'] == null
        ? null
        : AudioPlayerSetting.fromJson(
            json['audio_player_setting'] as Map<String, dynamic>),
    storageSetting: json['storage_setting'] == null
        ? null
        : StorageSetting.fromJson(
            json['storage_setting'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PreferenceValueToJson(PreferenceValue instance) =>
    <String, dynamic>{
      'queue_details': instance.queueDetails,
      'audio_player_setting': instance.audioPlayerSetting,
      'storage_setting': instance.storageSetting,
    };

QueueDetails _$QueueDetailsFromJson(Map<String, dynamic> json) {
  return QueueDetails(
    position: json['position'] as int,
  );
}

Map<String, dynamic> _$QueueDetailsToJson(QueueDetails instance) =>
    <String, dynamic>{
      'position': instance.position,
    };

AudioPlayerSetting _$AudioPlayerSettingFromJson(Map<String, dynamic> json) {
  return AudioPlayerSetting(
    seekForwardTime: json['seek_forward_time'] as int,
    seekBackwardTime: json['seek_backward_time'] as int,
  );
}

Map<String, dynamic> _$AudioPlayerSettingToJson(AudioPlayerSetting instance) =>
    <String, dynamic>{
      'seek_forward_time': instance.seekForwardTime,
      'seek_backward_time': instance.seekBackwardTime,
    };

StorageSetting _$StorageSettingFromJson(Map<String, dynamic> json) {
  return StorageSetting(
    storage: _$enumDecodeNullable(_$StorageEnumMap, json['storage']),
  );
}

Map<String, dynamic> _$StorageSettingToJson(StorageSetting instance) =>
    <String, dynamic>{
      'storage': _$StorageEnumMap[instance.storage],
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$StorageEnumMap = {
  Storage.internalStorage: 'internalStorage',
  Storage.externalStorage: 'externalStorage',
};
