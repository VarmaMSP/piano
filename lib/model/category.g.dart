// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) {
  return Category(
    id: json['id'] as String,
    urlParam: json['url_param'] as String,
    name: json['name'] as String,
    parentId: json['parent_id'] as String ?? '',
  );
}

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'id': instance.id,
      'url_param': instance.urlParam,
      'name': instance.name,
      'parent_id': instance.parentId,
    };
