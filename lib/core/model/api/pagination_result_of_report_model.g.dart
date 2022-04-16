// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination_result_of_report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginationResultOfReportModel _$PaginationResultOfReportModelFromJson(
        Map<String, dynamic> json) =>
    PaginationResultOfReportModel(
      result: (json['result'] as List<dynamic>)
          .map((e) => Report.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: json['total'] as int,
    );

Map<String, dynamic> _$PaginationResultOfReportModelToJson(
        PaginationResultOfReportModel instance) =>
    <String, dynamic>{
      'result': instance.result,
      'total': instance.total,
    };
