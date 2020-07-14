import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'setting.g.dart';

@CopyWith()
@JsonSerializable(fieldRename: FieldRename.snake)
class AudioPlayerSetting extends Equatable {
  static const key = 'AUDIO_PLAYER_PREFERENCE';

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
