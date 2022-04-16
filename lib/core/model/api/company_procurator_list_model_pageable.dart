import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'module_model_response.dart';

part 'company_procurator_list_model_pageable.g.dart';
@JsonSerializable()
class CompanyProcuratorListModelPageable extends Equatable{
  final int total;
  final List<ModuleModelResponse>? result;
  CompanyProcuratorListModelPageable({required this.total, this.result});

  factory CompanyProcuratorListModelPageable.fromJson(Map<String, dynamic> json) => _$CompanyProcuratorListModelPageableFromJson(json);
  Map<String, dynamic> toJson() => _$CompanyProcuratorListModelPageableToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [total,result];
}