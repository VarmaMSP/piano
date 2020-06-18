// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unnecessary_this, cast_to_non_type, return_of_invalid_type, constant_identifier_names, prefer_const_constructors_in_immutables, sort_unnamed_constructors_first, join_return_with_assignment

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
