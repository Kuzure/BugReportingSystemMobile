
import 'package:bugreportingsystem/core/model/api/report.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'pagination_result_of_report_model.g.dart';
@JsonSerializable()
class PaginationResultOfReportModel extends Equatable{
  final List<Report> result;
  final int total;
  PaginationResultOfReportModel({required this.result,required this.total});

  factory PaginationResultOfReportModel.fromJson(Map<String, dynamic> json) => _$PaginationResultOfReportModelFromJson(json);
  Map<String, dynamic> toJson() => _$PaginationResultOfReportModelToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [result,total];
}