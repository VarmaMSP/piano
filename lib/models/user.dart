import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    this.id,
    this.name,
    this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String ?? '',
    );
  }

  final String id;
  final String name;
  final String email;

  @override
  List<Object> get props => <String>[id];

  @override
  String toString() => 'User: { id: $id }';
}
