import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'comment_model.g.dart';

@JsonSerializable()
class CommentModel extends Equatable{
  final String id;
  final String reportId;
  final String? comment;
  final String? username;

  const CommentModel({
     required this.id,
     required this.reportId,
     this.comment,
     this.username,
  });
  factory CommentModel.fromJson(Map<String, dynamic> json) => _$CommentModelFromJson(json);
  Map<String, dynamic> toJson() => _$CommentModelToJson(this);


  @override
  List<Object> get props => [id, reportId,comment!,username!];

}