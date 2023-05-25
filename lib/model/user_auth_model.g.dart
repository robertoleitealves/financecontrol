// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_auth_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAuthModel _$UserAuthModelFromJson(Map<String, dynamic> json) =>
    UserAuthModel(
      nameUser: json['email'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$UserAuthModelToJson(UserAuthModel instance) =>
    <String, dynamic>{
      'email': instance.nameUser,
      'password': instance.password,
    };
