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
  );
}

Map<String, dynamic> _$PreferenceValueToJson(PreferenceValue instance) =>
    <String, dynamic>{
      'queue_details': instance.queueDetails,
      'audio_player_setting': instance.audioPlayerSetting,
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
