import 'package:json_annotation/json_annotation.dart';

part 'auth_event_model.g.dart';

enum AuthEventTypes
{
  LogIn,
  LogOut
}
@JsonSerializable()
class AuthEventModel {

  final int eventType;



  const AuthEventModel(
      this.eventType);

  factory AuthEventModel.fromJson(Map<String, dynamic> json) => _$AuthEventModelFromJson(json);
  Map<String, dynamic> toJson() => _$AuthEventModelToJson(this);

  List<Object> get props => [ eventType];
}