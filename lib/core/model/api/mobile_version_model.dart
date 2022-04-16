import 'package:json_annotation/json_annotation.dart';

part 'mobile_version_model.g.dart';

@JsonSerializable()
class MobileVersionModel {

  String version;

  MobileVersionModel(this.version);

  factory MobileVersionModel.fromJson(Map<String, dynamic> json) => _$MobileVersionModelFromJson(json);
  Map<String, dynamic> toJson() => _$MobileVersionModelToJson(this);
}