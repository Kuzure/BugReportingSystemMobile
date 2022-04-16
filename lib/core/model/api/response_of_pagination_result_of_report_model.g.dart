// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_of_pagination_result_of_report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseOfPaginationResultOfReportModel
    _$ResponseOfPaginationResultOfReportModelFromJson(
            Map<String, dynamic> json) =>
        ResponseOfPaginationResultOfReportModel(
          code: json['code'] as int,
          errors: (json['errors'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
          isError: json['isError'] as bool,
          result: PaginationResultOfReportModel.fromJson(
              json['result'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$ResponseOfPaginationResultOfReportModelToJson(
        ResponseOfPaginationResultOfReportModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'errors': instance.errors,
      'isError': instance.isError,
      'result': instance.result,
    };
