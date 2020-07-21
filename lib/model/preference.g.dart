// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unnecessary_this, return_of_invalid_type, constant_identifier_names, prefer_const_constructors_in_immutables, sort_unnamed_constructors_first, join_return_with_assignment

part of 'preference.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QueueDetails _$_$QueueDetailsFromJson(Map<String, dynamic> json) {
  return _$QueueDetails(
    position: json['position'] as int,
  );
}

Map<String, dynamic> _$_$QueueDetailsToJson(_$QueueDetails instance) =>
    <String, dynamic>{
      'position': instance.position,
    };

_$SubscriptionsRefreshDetails _$_$SubscriptionsRefreshDetailsFromJson(
    Map<String, dynamic> json) {
  return _$SubscriptionsRefreshDetails(
    lastRefreshedAt: json['lastRefreshedAt'] == null
        ? null
        : DateTime.parse(json['lastRefreshedAt'] as String),
  );
}

Map<String, dynamic> _$_$SubscriptionsRefreshDetailsToJson(
        _$SubscriptionsRefreshDetails instance) =>
    <String, dynamic>{
      'lastRefreshedAt': instance.lastRefreshedAt?.toIso8601String(),
    };

_$AudioPlayerSetting _$_$AudioPlayerSettingFromJson(Map<String, dynamic> json) {
  return _$AudioPlayerSetting(
    seekForwardTime: json['seekForwardTime'] as int,
    seekBackwardTime: json['seekBackwardTime'] as int,
  );
}

Map<String, dynamic> _$_$AudioPlayerSettingToJson(
        _$AudioPlayerSetting instance) =>
    <String, dynamic>{
      'seekForwardTime': instance.seekForwardTime,
      'seekBackwardTime': instance.seekBackwardTime,
    };

_$StorageSetting _$_$StorageSettingFromJson(Map<String, dynamic> json) {
  return _$StorageSetting(
    storage: _$enumDecodeNullable(_$StorageEnumMap, json['storage']),
    storagePath: json['storagePath'] as String,
  );
}

Map<String, dynamic> _$_$StorageSettingToJson(_$StorageSetting instance) =>
    <String, dynamic>{
      'storage': _$StorageEnumMap[instance.storage],
      'storagePath': instance.storagePath,
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
  Storage.none: 'none',
  Storage.internalStorage: 'internalStorage',
  Storage.externalStorage: 'externalStorage',
};
