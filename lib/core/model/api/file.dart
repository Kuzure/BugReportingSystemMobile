import 'package:json_annotation/json_annotation.dart';

part 'file.g.dart';
@JsonSerializable()
class FileSim{
  final String id;
  final String? fileId;
  final String? name;

  FileSim({ required this.id,   this.fileId,this.name});

  factory FileSim.fromJson(Map<String, dynamic> json) => _$FileSimFromJson(json);
  Map<String, dynamic> toJson() => _$FileSimToJson(this);

  List<Object> get props => [id,];
}