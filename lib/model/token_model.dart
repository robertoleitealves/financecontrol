// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:json_annotation/json_annotation.dart';

import '../constants/db_constants.dart';

part 'token_model.g.dart';

@JsonSerializable()
class TokenModel {
  String? token;
  int? userId;
  int? id;
  TokenModel({
    this.token,
    this.userId,
    this.id,
  });

  @override
  String toString() => 'TokenModel(token: $token, userId: $userId, id: $id)';

  factory TokenModel.fromJson(Map<String, dynamic> json) =>
      _$TokenModelFromJson(json);

  Map<String, dynamic> toJson() => _$TokenModelToJson(this);

  TokenModel.fromMapDb(Map<String, dynamic> map) {
    id = map[authIdColumn];
    token = map[authTokenColumn];
    userId = map[authTokenUserIdColumn];
  }

  Map<String, dynamic> toMapDb() {
    return <String, dynamic>{
      authTokenColumn: token,
      authTokenUserIdColumn: userId
    };
  }
}
