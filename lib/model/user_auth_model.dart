import 'package:json_annotation/json_annotation.dart';

part 'user_auth_model.g.dart';

@JsonSerializable()
class UserAuthModel {
  String nameUser;
  String password;


  UserAuthModel({
    required this.nameUser,
    required this.password,

  });

  factory UserAuthModel.fromJson(Map<String, dynamic> json) =>
      _$UserAuthModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserAuthModelToJson(this);
}
