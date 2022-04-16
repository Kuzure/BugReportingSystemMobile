

import 'package:json_annotation/json_annotation.dart';
part 'company_procurator_list_model.g.dart';
@JsonSerializable()
class CompanyProcuratorListModel{
  final String id;
  final String companyId;
  final String personId;
  final String? companyName;
  final String? personName;

  CompanyProcuratorListModel(
      {
    required this.id,
    required this.companyId,
    required this.personId,
    this.companyName,
    this.personName,
  });

  factory CompanyProcuratorListModel.fromJson(Map<String, dynamic> json) => _$CompanyProcuratorListModelFromJson(json);
  Map<String, dynamic> toJson() => _$CompanyProcuratorListModelToJson(this);

  List<Object> get props => [id,companyId,personId];
}