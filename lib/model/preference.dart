// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:phenopod/model/queue.dart';

part 'preference.g.dart';

// PreferenceValue represents the type of data that can be stored
// in key-value (preference) table.
@JsonSerializable(fieldRename: FieldRename.snake)
class PreferenceValue {
  @JsonKey(nullable: true)
  final QueueDetails queueDetails;

  @JsonKey(nullable: true)
  final AudioPlayerSetting audioPlayerSetting;

  @JsonKey(nullable: true)
  final StorageSetting storageSetting;

  const PreferenceValue({
    this.queueDetails,
    this.audioPlayerSetting,
    this.storageSetting,
  });

  factory PreferenceValue.fromJson(Map<String, dynamic> json) {
    return _$PreferenceValueFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$PreferenceValueToJson(this);
  }
}

//* QUEUE DETAILS *//
/// Used to store queue preference in preferences table
@JsonSerializable(fieldRename: FieldRename.snake)
class QueueDetails extends Equatable {
  static const String key = 'QUEUE_DETAILS';

  // Position of current active audio track
  final int position;

  const QueueDetails({
    @required this.position,
  });

  factory QueueDetails.fromQueue(Queue queue) {
    return QueueDetails(position: queue.position);
  }

  factory QueueDetails.fromJson(Map<String, dynamic> json) {
    return _$QueueDetailsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$QueueDetailsToJson(this);
  }

  @override
  List<Object> get props => [position];
}

//* AUDIO PLAYER SETTING *//
@CopyWith()
@JsonSerializable(fieldRename: FieldRename.snake)
class AudioPlayerSetting extends Equatable {
  static const String key = 'AUDIO_PLAYER_SETTING';

  // Seconds to move when forwarded
  final int seekForwardTime;

  // Seconds to move when rewinded
  final int seekBackwardTime;

  AudioPlayerSetting({
    @required this.seekForwardTime,
    @required this.seekBackwardTime,
  });

  factory AudioPlayerSetting.standard() {
    return AudioPlayerSetting(seekForwardTime: 30, seekBackwardTime: 30);
  }

  factory AudioPlayerSetting.fromJson(Map<String, dynamic> json) {
    return _$AudioPlayerSettingFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AudioPlayerSettingToJson(this);
  }

  @override
  List<Object> get props => [seekForwardTime, seekBackwardTime];
}

enum Storage {
  internalStorage,
  externalStorage,
}

//* STORAGE SETTING *//
@CopyWith()
@JsonSerializable(fieldRename: FieldRename.snake)
class StorageSetting extends Equatable {
  static const String key = 'STORAGE_SETTING';

  // Storage location for audio files
  final Storage storage;

  StorageSetting({this.storage});

  factory StorageSetting.standard() {
    return StorageSetting(storage: Storage.internalStorage);
  }

  factory StorageSetting.fromJson(Map<String, dynamic> json) {
    return _$StorageSettingFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$StorageSettingToJson(this);
  }

  @override
  List<Object> get props => [storage];
}
