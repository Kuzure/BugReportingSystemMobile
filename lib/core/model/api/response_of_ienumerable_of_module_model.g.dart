// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_of_ienumerable_of_module_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseOfIEnumerableOfModuleModel _$ResponseOfIEnumerableOfModuleModelFromJson(
        Map<String, dynamic> json) =>
    ResponseOfIEnumerableOfModuleModel(
      code: json['code'] as int,
      errors:
          (json['errors'] as List<dynamic>?)?.map((e) => e as String).toList(),
      isError: json['isError'] as bool,
      result: (json['result'] as List<dynamic>?)
          ?.map((e) => ModuleModelResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResponseOfIEnumerableOfModuleModelToJson(
        ResponseOfIEnumerableOfModuleModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'errors': instance.errors,
      'isError': instance.isError,
      'result': instance.result,
    };
