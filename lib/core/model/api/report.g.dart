// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Report _$ReportFromJson(Map<String, dynamic> json) => Report(
      id: json['id'] as String,
      moduleId: json['moduleId'] as String,
      simId: json['simId'] as String,
      module: json['module'] == null
          ? null
          : ModuleModel.fromJson(json['module'] as Map<String, dynamic>),
      username: json['username'] as String?,
      email: json['email'] as String?,
      description: json['description'] as String?,
      reportNumber: json['reportNumber'] as int,
      comments: (json['comments'] as List<dynamic>?)
          ?.map((e) => CommentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      redmine: json['redmine'] as int?,
      type: json['type'] as int,
      priority: json['priority'] as int,
      status: json['status'] as int,
      attachments: (json['attachments'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : AttachmentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      fillingTime: json['fillingTime'] as String?,
      simNumber: json['simNumber'] as String?,
      applicantFirstName: json['applicantFirstName'] as String?,
      applicantLastName: json['applicantLastName'] as String?,
      supervisorId: json['supervisorId'] as String?,
      supervisorFirstName: json['supervisorFirstName'] as String?,
      supervisorLastName: json['supervisorLastName'] as String?,
      supervisorComment: json['supervisorComment'] as String?,
      supervisorEmail: json['supervisorEmail'] as String?,
      supervisorPhoneNumber: json['supervisorPhoneNumber'] as String?,
      mobileFirstName: json['mobileFirstName'] as String?,
      mobileLastName: json['mobileLastName'] as String?,
    );

Map<String, dynamic> _$ReportToJson(Report instance) => <String, dynamic>{
      'id': instance.id,
      'moduleId': instance.moduleId,
      'simId': instance.simId,
      'module': instance.module,
      'username': instance.username,
      'email': instance.email,
      'description': instance.description,
      'reportNumber': instance.reportNumber,
      'comments': instance.comments,
      'redmine': instance.redmine,
      'type': instance.type,
      'priority': instance.priority,
      'status': instance.status,
      'attachments': instance.attachments,
      'fillingTime': instance.fillingTime,
      'simNumber': instance.simNumber,
      'applicantFirstName': instance.applicantFirstName,
      'applicantLastName': instance.applicantLastName,
      'supervisorId': instance.supervisorId,
      'supervisorFirstName': instance.supervisorFirstName,
      'supervisorLastName': instance.supervisorLastName,
      'supervisorComment': instance.supervisorComment,
      'supervisorEmail': instance.supervisorEmail,
      'supervisorPhoneNumber': instance.supervisorPhoneNumber,
      'mobileFirstName': instance.mobileFirstName,
      'mobileLastName': instance.mobileLastName,
    };
