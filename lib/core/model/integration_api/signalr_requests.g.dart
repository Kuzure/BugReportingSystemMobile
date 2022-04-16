// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signalr_requests.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignalrScaleValueRequest _$SignalrScaleValueRequestFromJson(
        Map<String, dynamic> json) =>
    SignalrScaleValueRequest(
      json['nodeId'] as String,
      json['registrationNumber'] as String,
    );

Map<String, dynamic> _$SignalrScaleValueRequestToJson(
        SignalrScaleValueRequest instance) =>
    <String, dynamic>{
      'nodeId': instance.nodeId,
      'registrationNumber': instance.registrationNumber,
    };
