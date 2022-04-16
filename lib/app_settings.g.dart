// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthSettings _$AuthSettingsFromJson(Map<String, dynamic> json) => AuthSettings(
      baseUrl: json['baseUrl'] as String,
      tokenEndpoint: json['tokenEndpoint'] as String,
      clientId: json['clientId'] as String,
    );

Map<String, dynamic> _$AuthSettingsToJson(AuthSettings instance) =>
    <String, dynamic>{
      'baseUrl': instance.baseUrl,
      'tokenEndpoint': instance.tokenEndpoint,
      'clientId': instance.clientId,
    };

ApiSettings _$ApiSettingsFromJson(Map<String, dynamic> json) => ApiSettings(
      coreUrl: json['coreUrl'] as String,
      integrationUrl: json['integrationUrl'] as String,
      signalrUrl: json['signalrUrl'] as String,
      secondUrl: json['secondUrl'] as String,
    );

Map<String, dynamic> _$ApiSettingsToJson(ApiSettings instance) =>
    <String, dynamic>{
      'coreUrl': instance.coreUrl,
      'integrationUrl': instance.integrationUrl,
      'signalrUrl': instance.signalrUrl,
      'secondUrl': instance.secondUrl,
    };
