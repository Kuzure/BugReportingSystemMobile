// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddReport _$AddReportFromJson(Map<String, dynamic> json) => AddReport(
      id: json['id'] as String,
      moduleId: json['moduleId'] as String,
      simId: json['simId'] as String,
      email: json['email'] as String?,
      description: json['description'] as String?,
      username: json['username'] as String?,
      reportNumber: json['reportNumber'] as int,
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
      mobileIMEI: json['mobileIMEI'] as String?,
      mobilePhoneNumber: json['mobilePhoneNumber'] as String?,
      source: json['source'] as String?,
      fillFormStartDate: json['fillFormStartDate'] as String,
      comments: (json['comments'] as List<dynamic>?)
          ?.map((e) => CommentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      redmine: json['redmine'] as int,
      type: json['type'] as int,
      priority: json['priority'] as int,
      status: json['status'] as int,
      fillFormTime: json['fillFormTime'] as String,
    );

Map<String, dynamic> _$AddReportToJson(AddReport instance) => <String, dynamic>{
      'id': instance.id,
      'moduleId': instance.moduleId,
      'simId': instance.simId,
      'email': instance.email,
      'description': instance.description,
      'username': instance.username,
      'reportNumber': instance.reportNumber,
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
      'mobileIMEI': instance.mobileIMEI,
      'mobilePhoneNumber': instance.mobilePhoneNumber,
      'fillFormStartDate': instance.fillFormStartDate,
      'comments': instance.comments,
      'redmine': instance.redmine,
      'type': instance.type,
      'priority': instance.priority,
      'status': instance.status,
      'fillFormTime': instance.fillFormTime,
      'source': instance.source,
    };
