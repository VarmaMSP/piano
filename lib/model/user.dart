import 'package:equatable/equatable.dart';
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
