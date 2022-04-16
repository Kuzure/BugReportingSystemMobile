import 'package:bugreportingsystem/core/model/api/pagination_result_of_report_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'response_of_pagination_result_of_report_model.g.dart';
@JsonSerializable()
class ResponseOfPaginationResultOfReportModel extends Equatable{
  final int code;
  final List<String>? errors;
  final bool isError;
  final PaginationResultOfReportModel result;
  ResponseOfPaginationResultOfReportModel({required this.code,this.errors,required this.isError,required this.result});

  factory ResponseOfPaginationResultOfReportModel.fromJson(Map<String, dynamic> json) => _$ResponseOfPaginationResultOfReportModelFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseOfPaginationResultOfReportModelToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [code,errors,isError,result];
}