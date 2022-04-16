import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'person_model.g.dart';

@JsonSerializable()
class PersonModel extends Equatable {
  final String id;
  final String? firstName;
  final String? lastName;
  final String? pesel;
  final String? contactNumber;
  final String? email;
  final String? categoryId;
  final String? categoryName;
  final int contractType;
  final String? contractTypeName;
  final bool isEnterpreneur;
  final String? positionName;
  final String positionId;
  final String? companyName;
  final String companyId;
  final String?  mpk;
  final String mpkId;

  PersonModel(
      {required this.id, this.firstName, this.lastName, this.pesel, this.contactNumber, this.email, this.categoryId, this.categoryName, required this.contractType, this.contractTypeName, required this.isEnterpreneur,this.positionName,  required this.positionId, this.companyName, required this.companyId, this.mpk,required this.mpkId,});


  factory PersonModel.fromJson(Map<String, dynamic> json) => _$PersonModelFromJson(json);
  Map<String, dynamic> toJson() => _$PersonModelToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [];

}