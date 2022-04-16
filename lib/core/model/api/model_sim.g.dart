// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_sim.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SimModel _$SimModelFromJson(Map<String, dynamic> json) => SimModel(
      id: json['id'] as String,
      phoneNumber: json['phoneNumber'] as String?,
      serialNumber: json['serialNumber'] as String?,
      type: json['type'] as int,
      typeName: json['typeName'] as String?,
      pin: json['pin'] as String?,
      puk: json['puk'] as String?,
      mpkId: json['mpkId'] as String?,
      personPositionId: json['personPositionId'] as String?,
      deviceId: json['deviceId'] as String?,
      limitId: json['limitId'] as String?,
      serviceId: json['serviceId'] as String?,
      limit: (json['limit'] as num).toDouble(),
      mpk: json['mpk'] as String?,
      service: json['service'] as String?,
      deviceName: json['deviceName'] as String?,
      personName: json['personName'] as String?,
      imei: json['imei'] as String?,
      roamingEnabled: json['roamingEnabled'] as bool,
      isInDeposit: json['isInDeposit'] as bool,
      isRenewable: json['isRenewable'] as bool,
      plan: json['plan'] as String?,
      abonentAccount: json['abonentAccount'] as String?,
      contractNumber: json['contractNumber'] as String?,
      contractAnnex: json['contractAnnex'] as String?,
      subscriptionFee: (json['subscriptionFee'] as num).toDouble(),
      activationFee: (json['activationFee'] as num).toDouble(),
      files: (json['files'] as List<dynamic>?)
          ?.map((e) =>
              e == null ? null : FileSim.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SimModelToJson(SimModel instance) => <String, dynamic>{
      'id': instance.id,
      'phoneNumber': instance.phoneNumber,
      'serialNumber': instance.serialNumber,
      'type': instance.type,
      'typeName': instance.typeName,
      'pin': instance.pin,
      'puk': instance.puk,
      'mpkId': instance.mpkId,
      'personPositionId': instance.personPositionId,
      'deviceId': instance.deviceId,
      'limitId': instance.limitId,
      'serviceId': instance.serviceId,
      'limit': instance.limit,
      'mpk': instance.mpk,
      'service': instance.service,
      'deviceName': instance.deviceName,
      'personName': instance.personName,
      'imei': instance.imei,
      'roamingEnabled': instance.roamingEnabled,
      'isInDeposit': instance.isInDeposit,
      'isRenewable': instance.isRenewable,
      'plan': instance.plan,
      'abonentAccount': instance.abonentAccount,
      'contractNumber': instance.contractNumber,
      'contractAnnex': instance.contractAnnex,
      'subscriptionFee': instance.subscriptionFee,
      'activationFee': instance.activationFee,
      'files': instance.files,
    };
