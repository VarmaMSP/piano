// GENERATED CODE - DO NOT MODIFY BY HAND

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
