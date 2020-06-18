// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unnecessary_this, return_of_invalid_type, constant_identifier_names, prefer_const_constructors_in_immutables, sort_unnamed_constructors_first, join_return_with_assignment

part of 'curation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Curation _$CurationFromJson(Map<String, dynamic> json) {
  return Curation(
    id: json['id'] as String,
    title: json['title'] as String,
    podcasts: (json['podcasts'] as List)
        ?.map((e) =>
            e == null ? null : Podcast.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CurationToJson(Curation instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'podcasts': instance.podcasts,
    };
