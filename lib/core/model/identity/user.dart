
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';
@JsonSerializable()
class User extends Equatable{
  final String sub;


  final String role;

  @JsonKey(name: 'email_verified')
  final String? emailVerified;

  final String email;

  //@JsonKey(name: 'EnumPermission')
  //final List<String> enumPermission;


  const User(
      this.sub,
      this.role,
      this.emailVerified,
      this.email);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  List<Object> get props => [sub, role, email];
}
class UserRoles{
  static const String user = 'Użytkownik';
  static const String admin = 'Admin';
}