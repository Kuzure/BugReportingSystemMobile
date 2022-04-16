import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'comment_model.dart';

part 'add_report.g.dart';

enum TypeEnum{Standard,VIP}
enum PriorityEnum{
  Normal,
  High,
}
enum StatusEnum{
  Reported,
  InProgress,
  Realized,
  Opened,
  Closed,
  Cancellation,
  Error}
@JsonSerializable()
class AddReport extends Equatable {
   final String id;
   final String moduleId;
   final String simId;
   final String? email;
   final String? description;
   final String? username;
   final int reportNumber;
   final String? simNumber;
   final String? applicantFirstName;
   final String? applicantLastName;
  final String? supervisorId;
  final String? supervisorFirstName;
  final String? supervisorLastName;
  final String? supervisorComment;
  final String? supervisorEmail;
  final String? supervisorPhoneNumber;
  final String? mobileFirstName;
  final String? mobileLastName;
  final String? mobileIMEI;
  final String? mobilePhoneNumber;
  final String fillFormStartDate;
  final List<CommentModel>? comments;
  final int redmine;
  final int type;
  final int priority;
  final int status;
  final String fillFormTime;
  final String? source;
  const AddReport(
      {
    required this.id,
    required this.moduleId,
    required this.simId,
    this.email,
    this.description,
    this.username,
    required this.reportNumber,
    this.simNumber,
    this.applicantFirstName,
    this.applicantLastName,
    this.supervisorId,
    this.supervisorFirstName,
    this.supervisorLastName,
    this.supervisorComment,
    this.supervisorEmail,
    this.supervisorPhoneNumber,
        this.mobileFirstName,
        this.mobileLastName,
        this.mobileIMEI,
        this.mobilePhoneNumber,
        this.source,
        required this.fillFormStartDate,
    this.comments,
    required this.redmine,
    required this.type,
    required this.priority,
    required this.status,
    required this.fillFormTime,
  });


  factory AddReport.fromJson(Map<String, dynamic> json) => _$AddReportFromJson(json);
  Map<String, dynamic> toJson() => _$AddReportToJson(this);


  @override
  List<Object?> get props => [];
}