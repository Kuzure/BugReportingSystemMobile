import 'dart:core';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'file.dart';

part 'model_sim.g.dart';

@JsonSerializable()
class SimModel extends Equatable {
  final String id;
  final String? phoneNumber;
  final String? serialNumber;
  final int type;
  final String? typeName;
  final String? pin;
  final String? puk;
  final String? mpkId;
  final String? personPositionId;
  final String? deviceId;
  final String? limitId;
  final String? serviceId;
  final double limit;
  final String? mpk;
  final String? service;
  final String? deviceName;
  final String? personName;
  final String? imei;
  final bool roamingEnabled;
  final bool isInDeposit;
  final bool isRenewable;
  final String? plan;
  final String? abonentAccount;
  final String? contractNumber;
  final String? contractAnnex;
  final double subscriptionFee;
  final double activationFee;
  final List<FileSim?>? files;

  SimModel(
      {
    required this.id,
    this.phoneNumber,
    this.serialNumber,
    required this.type,
    this.typeName,
    this.pin,
    this.puk,
    this.mpkId,
    this.personPositionId,
    this.deviceId,
    this.limitId,
    this.serviceId,
    required this.limit,
    this.mpk,
    this.service,
    this.deviceName,
    this.personName,
    this.imei,
    required this.roamingEnabled,
    required this.isInDeposit,
    required this.isRenewable,
    this.plan,
    this.abonentAccount,
    this.contractNumber,
    this.contractAnnex,
    required this.subscriptionFee,
    required this.activationFee,
    this.files,
  });

  factory SimModel.fromJson(Map<String, dynamic> json) => _$SimModelFromJson(json);
  Map<String, dynamic> toJson() => _$SimModelToJson(this);
  @override
  // TODO: implement props
  List<Object?> get props => [id];
}