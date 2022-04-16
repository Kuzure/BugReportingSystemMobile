// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_procurator_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyProcuratorListModel _$CompanyProcuratorListModelFromJson(
        Map<String, dynamic> json) =>
    CompanyProcuratorListModel(
      id: json['id'] as String,
      companyId: json['companyId'] as String,
      personId: json['personId'] as String,
      companyName: json['companyName'] as String?,
      personName: json['personName'] as String?,
    );

Map<String, dynamic> _$CompanyProcuratorListModelToJson(
        CompanyProcuratorListModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'companyId': instance.companyId,
      'personId': instance.personId,
      'companyName': instance.companyName,
      'personName': instance.personName,
    };
