// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unnecessary_this, return_of_invalid_type, constant_identifier_names, prefer_const_constructors_in_immutables, sort_unnamed_constructors_first, join_return_with_assignment

part of 'setting.dart';

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
