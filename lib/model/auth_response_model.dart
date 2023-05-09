// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:financecontrol/model/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_response_model.g.dart';

@JsonSerializable()
class AuthResponseModel {
  Token token;
  UserModel user;
  int? id;

  AuthResponseModel({
    required this.token,
    required this.user,
    this.id,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResponseModelToJson(this);

  @override
  String toString() => 'AuthResponseModel(token: $token, user: $user, id: $id)';
}

class Token {
  String type;
  String token;

  Token({
    required this.type,
    required this.token,
  });

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      type: json['type'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['token'] = token;
    return data;
  }

  @override
  String toString() => 'Token(type: $type, token: $token)';
}
