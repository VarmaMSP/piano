import 'package:equatable/equatable.dart';

class Category extends Equatable {
  const Category({
    this.id,
    this.urlParam,
    this.name,
    this.parentId,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as String,
      urlParam: json['url_param'] as String,
      name: json['name'] as String,
      parentId: json['parent_id'] as String,
    );
  }

  final String id;
  final String urlParam;
  final String name;
  final String parentId;

  @override
  List<Object> get props => <String>[id];

  @override
  String toString() => 'Category: { id: $id }';
}
