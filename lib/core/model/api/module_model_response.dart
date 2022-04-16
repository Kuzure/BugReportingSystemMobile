import 'package:json_annotation/json_annotation.dart';

part 'module_model_response.g.dart';

@JsonSerializable()
class ModuleModelResponse{
  final String id;
  final String? label;

  const ModuleModelResponse({
    required this.id,
    this.label
  });
  factory ModuleModelResponse.fromJson(Map<String, dynamic> json) => _$ModuleModelResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ModuleModelResponseToJson(this);

}