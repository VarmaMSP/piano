// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unnecessary_this, return_of_invalid_type, constant_identifier_names, prefer_const_constructors_in_immutables, sort_unnamed_constructors_first, join_return_with_assignment

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    id: json['id'] as String,
    name: json['name'] as String,
    email: json['email'] as String ?? '',
  );
}

GuestCredentials _$GuestCredentialsFromJson(Map<String, dynamic> json) {
  return GuestCredentials(
    id: json['id'] as String,
    deviceUuid: json['device_uuid'] as String,
    deviceOs: json['device_os'] as String,
    deviceModel: json['device_model'] as String,
  );
}

Map<String, dynamic> _$GuestCredentialsToJson(GuestCredentials instance) =>
    <String, dynamic>{
      'id': instance.id,
      'device_uuid': instance.deviceUuid,
      'device_os': instance.deviceOs,
      'device_model': instance.deviceModel,
    };
