import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
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
  final TableLock taskTableLock;

  const PreferenceValue({
    this.queueDetails,
    this.audioPlayerSetting,
    this.taskTableLock,
  });

  // A convience method to return default values where ever
  // appropriate for ui (Usually when app is first started
  // when all fields are null).
  factory PreferenceValue.fromNull() {
    return PreferenceValue(
      queueDetails: QueueDetails.fromQueue(Queue.empty()),
      audioPlayerSetting: AudioPlayerSetting.standard(),
      taskTableLock: null,
    );
  }

  factory PreferenceValue.fromJson(Map<String, dynamic> json) {
    return _$PreferenceValueFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$PreferenceValueToJson(this);
  }
}

@JsonSerializable(fieldRename: FieldRename.snake)
class TableLock {
  static const String taskTableKey = 'TASK_TABLE_LOCK';

  // Time at which the lock is created
  final DateTime createdAt;

  TableLock({this.createdAt});

  factory TableLock.fromJson(Map<String, dynamic> json) {
    return _$TableLockFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$TableLockToJson(this);
  }
}

/// Used to store queue preference in preferences table
@JsonSerializable(fieldRename: FieldRename.snake)
class QueueDetails extends Equatable {
  static const String key = 'QUEUE_DETAILS';

  // Position of current active audio track
  final int position;

  const QueueDetails({this.position});

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

// Value for audio player settings
@CopyWith()
@JsonSerializable(fieldRename: FieldRename.snake)
class AudioPlayerSetting extends Equatable {
  static const String key = 'AUDIO_PLAYER_SETTING';

  // Seconds to move when forwarded
  final int seekForwardTime;

  // Seconds to move when rewinded
  final int seekBackwardTime;

  AudioPlayerSetting({this.seekForwardTime, this.seekBackwardTime});

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
