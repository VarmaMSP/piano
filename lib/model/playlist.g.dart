// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unnecessary_this, cast_to_non_type, return_of_invalid_type, constant_identifier_names, prefer_const_constructors_in_immutables, sort_unnamed_constructors_first, join_return_with_assignment

part of 'playlist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Playlist _$PlaylistFromJson(Map<String, dynamic> json) {
  return Playlist(
    id: json['id'] as String,
    urlParam: json['url_param'] as String,
    userId: json['user_id'] as String,
    title: json['title'] as String,
    description: json['description'] as String ?? '',
    privacy: json['privacy'] as String ?? 'PUBLIC',
    episodeCount: json['episode_count'] as int ?? 0,
    previewImage: json['preview_image'] as String ?? '',
    updatedAt: json['updated_at'] as String ?? '',
    members: (json['members'] as List)
            ?.map((e) => e == null
                ? null
                : PlaylistMember.fromJson(e as Map<String, dynamic>))
            ?.toList() ??
        [],
  );
}

Map<String, dynamic> _$PlaylistToJson(Playlist instance) => <String, dynamic>{
      'id': instance.id,
      'url_param': instance.urlParam,
      'user_id': instance.userId,
      'title': instance.title,
      'description': instance.description,
      'privacy': instance.privacy,
      'episode_count': instance.episodeCount,
      'preview_image': instance.previewImage,
      'updated_at': instance.updatedAt,
      'members': instance.members,
    };

PlaylistMember _$PlaylistMemberFromJson(Map<String, dynamic> json) {
  return PlaylistMember(
    episodeId: json['episode_id'] as String,
    position: json['position'] as int,
  );
}

Map<String, dynamic> _$PlaylistMemberToJson(PlaylistMember instance) =>
    <String, dynamic>{
      'episode_id': instance.episodeId,
      'position': instance.position,
    };
