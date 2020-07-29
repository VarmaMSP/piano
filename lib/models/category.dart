part of 'main.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Category extends Equatable {
  final String id;
  final String urlParam;
  final String name;

  @JsonKey(defaultValue: '')
  final String parentId;

  const Category({
    this.id,
    this.urlParam,
    this.name,
    this.parentId,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return _$CategoryFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CategoryToJson(this);
  }

  @override
  List<Object> get props => [id];

  @override
  String toString() => 'Category: { name: $name }';
}
