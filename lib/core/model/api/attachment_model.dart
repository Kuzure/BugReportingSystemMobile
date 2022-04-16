

import 'package:json_annotation/json_annotation.dart';
part 'attachment_model.g.dart';
@JsonSerializable()
class AttachmentModel{
  final String id;
  final String fileName;
  final String? fileStream;
  final String? reportId;

  AttachmentModel({ required this.id,  required this.fileName,this.fileStream,  this.reportId});

  factory AttachmentModel.fromJson(Map<String, dynamic> json) => _$AttachmentModelFromJson(json);
  Map<String, dynamic> toJson() => _$AttachmentModelToJson(this);

  List<Object> get props => [id,fileName];
}