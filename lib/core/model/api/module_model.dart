import 'package:json_annotation/json_annotation.dart';

part 'module_model.g.dart';

@JsonSerializable()
class ModuleModel{
  final String id;
  final String? name;

  const ModuleModel({
    required this.id,
     this.name
});
  factory ModuleModel.fromJson(Map<String, dynamic> json) => _$ModuleModelFromJson(json);
  Map<String, dynamic> toJson() => _$ModuleModelToJson(this);

}