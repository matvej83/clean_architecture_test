// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_token_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AuthTokenModel _$AuthTokenModelFromJson(Map<String, dynamic> json) =>
    _AuthTokenModel(
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String,
    );

Map<String, dynamic> _$AuthTokenModelToJson(_AuthTokenModel instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'refresh_token': instance.refreshToken,
    };
