// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonModel _$PersonModelFromJson(Map<String, dynamic> json) => PersonModel(
      id: json['id'] as String,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      pesel: json['pesel'] as String?,
      contactNumber: json['contactNumber'] as String?,
      email: json['email'] as String?,
      categoryId: json['categoryId'] as String?,
      categoryName: json['categoryName'] as String?,
      contractType: json['contractType'] as int,
      contractTypeName: json['contractTypeName'] as String?,
      isEnterpreneur: json['isEnterpreneur'] as bool,
      positionName: json['positionName'] as String?,
      positionId: json['positionId'] as String,
      companyName: json['companyName'] as String?,
      companyId: json['companyId'] as String,
      mpk: json['mpk'] as String?,
      mpkId: json['mpkId'] as String,
    );

Map<String, dynamic> _$PersonModelToJson(PersonModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'pesel': instance.pesel,
      'contactNumber': instance.contactNumber,
      'email': instance.email,
      'categoryId': instance.categoryId,
      'categoryName': instance.categoryName,
      'contractType': instance.contractType,
      'contractTypeName': instance.contractTypeName,
      'isEnterpreneur': instance.isEnterpreneur,
      'positionName': instance.positionName,
      'positionId': instance.positionId,
      'companyName': instance.companyName,
      'companyId': instance.companyId,
      'mpk': instance.mpk,
      'mpkId': instance.mpkId,
    };
