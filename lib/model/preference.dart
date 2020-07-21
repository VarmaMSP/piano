import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'preference.freezed.dart';
part 'preference.g.dart';

enum Storage {
  none,
  internalStorage,
  externalStorage,
}

@freezed
abstract class PreferenceValue with _$PreferenceValue {
  //* QUEUE DETAILS *//
  const factory PreferenceValue.queueDetails({
    @required int position,
  }) = QueueDetails;

  //* SUBSCRIPTION REFRESH DETAILS *//
  const factory PreferenceValue.subscriptionsRefreshDetails({
    @required DateTime lastRefreshedAt,
  }) = SubscriptionsRefreshDetails;

  //* AUDIO PLAYER SETTING *//
  const factory PreferenceValue.audioPlayerSetting({
    @required int seekForwardTime,
    @required int seekBackwardTime,
  }) = AudioPlayerSetting;

  //* STORAGE SETTING *//
  const factory PreferenceValue.storageSetting({
    @required Storage storage,
    @required String storagePath,
  }) = StorageSetting;

  factory PreferenceValue.fromJson(Map<String, dynamic> json) =>
      _$PreferenceValueFromJson(json);
}

class Preference {
  final String key;
  final PreferenceValue value;

  Preference({
    @required this.key,
    @required this.value,
  });
}
