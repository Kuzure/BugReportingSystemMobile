// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      json['sub'] as String,
      json['role'] as String,
      json['email_verified'] as String?,
      json['email'] as String,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'sub': instance.sub,
      'role': instance.role,
      'email_verified': instance.emailVerified,
      'email': instance.email,
    };
