import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_info.g.dart';
@JsonSerializable()
class UserInfo extends Equatable {

  @JsonKey(name: 'nodeId')
  final String nodeId;


  const UserInfo(
      this.nodeId,
      );

  factory UserInfo.fromJson(Map<String, dynamic> json) => _$UserInfoFromJson(json);
  Map<String, dynamic> toJson() => _$UserInfoToJson(this);

  @override
  List<Object> get props => [nodeId];
}