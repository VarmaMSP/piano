import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import 'package:device_info/device_info.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, createToJson: false)
class User extends Equatable {
  final String id;
  final String name;

  @JsonKey(defaultValue: '')
  final String email;

  const User({
    this.id,
    this.name,
    this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return _$UserFromJson(json);
  }

  @override
  List<Object> get props => <String>[id];

  @override
  String toString() => 'User: { id: $id }';
}

@JsonSerializable(fieldRename: FieldRename.snake)
class GuestCredentials {
  final String id;
  final String deviceUuid;
  final String deviceOs;
  final String deviceModel;

  GuestCredentials({
    @required this.id,
    @required this.deviceUuid,
    @required this.deviceOs,
    @required this.deviceModel,
  });

  factory GuestCredentials.fromJson(Map<String, dynamic> json) {
    return _$GuestCredentialsFromJson(json);
  }

  factory GuestCredentials.fromAndroidDeviceInfo(AndroidDeviceInfo info) {
    return GuestCredentials(
      id: Uuid().v4(),
      deviceModel: '${info.manufacturer} ${info.model}',
      deviceOs: 'Android ${info.version.release} ${info.version.sdkInt}',
      deviceUuid: info.androidId,
    );
  }

  factory GuestCredentials.fromIosDeviceInfo(IosDeviceInfo info) {
    return GuestCredentials(
      id: Uuid().v4(),
      deviceModel: info.utsname.machine,
      deviceOs: '${info.systemName} ${info.systemVersion}',
      deviceUuid: info.identifierForVendor,
    );
  }

  Map<String, dynamic> toJson() {
    return _$GuestCredentialsToJson(this);
  }
}
