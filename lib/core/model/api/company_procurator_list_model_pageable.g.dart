// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_procurator_list_model_pageable.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyProcuratorListModelPageable _$CompanyProcuratorListModelPageableFromJson(
        Map<String, dynamic> json) =>
    CompanyProcuratorListModelPageable(
      total: json['total'] as int,
      result: (json['result'] as List<dynamic>?)
          ?.map((e) => ModuleModelResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CompanyProcuratorListModelPageableToJson(
        CompanyProcuratorListModelPageable instance) =>
    <String, dynamic>{
      'total': instance.total,
      'result': instance.result,
    };
