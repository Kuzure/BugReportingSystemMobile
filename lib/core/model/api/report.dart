import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'attachment_model.dart';
import 'comment_model.dart';
import 'module_model.dart';
part 'report.g.dart';
enum TypeEnum{Standard,
  VIP}
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
class Report extends Equatable {
  final String id;
  final String moduleId;
  final String simId;
  final ModuleModel? module;
  final String? username;
  final String? email;
  final String? description;
  final int reportNumber;
  final List<CommentModel>? comments;
  final int? redmine;
  final int type;
  final int priority;
  final int status;
  final List<AttachmentModel?>? attachments;
  final String? fillingTime;
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
  Report(
      {required this.id,
      required this.moduleId,
      required this.simId,
      this.module,
      this.username,
      this.email,
      this.description,
      required this.reportNumber,
       this.comments,
       this.redmine,
      required this.type,
      required this.priority,
      required this.status,
        this.attachments,
       this.fillingTime,
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
   });


  factory Report.fromJson(Map<String, dynamic> json) => _$ReportFromJson(json);
  Map<String, dynamic> toJson() => _$ReportToJson(this);

  @override
  // TODO: implement props
  List<Object> get props => [
    ];



}
