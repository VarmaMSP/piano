// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unnecessary_this, return_of_invalid_type, constant_identifier_names, prefer_const_constructors_in_immutables, sort_unnamed_constructors_first, join_return_with_assignment

part of 'queue.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension QueuePreferenceCopyWithExtension on QueuePreference {
  QueuePreference copyWith({
    bool enabled,
    int position,
  }) {
    return QueuePreference(
      enabled: enabled ?? this.enabled,
      position: position ?? this.position,
    );
  }
}

extension QueueCopyWithExtension on Queue {
  Queue copyWith({
    List<AudioTrack> audioTracks,
    bool enabled,
    int position,
  }) {
    return Queue(
      audioTracks: audioTracks ?? this.audioTracks,
      enabled: enabled ?? this.enabled,
      position: position ?? this.position,
    );
  }
}

extension AudioTrackCopyWithExtension on AudioTrack {
  AudioTrack copyWith({
    Episode episode,
    Podcast podcast,
    int position,
  }) {
    return AudioTrack(
      episode: episode ?? this.episode,
      podcast: podcast ?? this.podcast,
      position: position ?? this.position,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QueuePreference _$QueuePreferenceFromJson(Map<String, dynamic> json) {
  return QueuePreference(
    position: json['position'] as int,
    enabled: json['enabled'] as bool,
  );
}

Map<String, dynamic> _$QueuePreferenceToJson(QueuePreference instance) =>
    <String, dynamic>{
      'position': instance.position,
      'enabled': instance.enabled,
    };
