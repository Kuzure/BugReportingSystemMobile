import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'module_model_response.dart';

part 'response_of_ienumerable_of_module_model.g.dart';
@JsonSerializable()
class ResponseOfIEnumerableOfModuleModel extends Equatable{
  final int code;
  final List<String>? errors;
  final bool isError;
  final List<ModuleModelResponse>? result;
  ResponseOfIEnumerableOfModuleModel({required this.code,this.errors,required this.isError, this.result});

  factory ResponseOfIEnumerableOfModuleModel.fromJson(Map<String, dynamic> json) => _$ResponseOfIEnumerableOfModuleModelFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseOfIEnumerableOfModuleModelToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [code,errors,isError,result];
}