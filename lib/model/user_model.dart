// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../constants/db_constants.dart';

class UserModel {
  int? id;
  String? name;
  String? username;
  String? cpfNumber;
  String? birthdate;
  String? phoneNumber;
  String? password;

  UserModel(
      {this.name,
      this.username,
      this.cpfNumber,
      this.birthdate,
      this.phoneNumber,
      this.password});

  UserModel.fromMapDB(Map<String, dynamic> json) {
    id = json[userIdColumn];
    name = json[userNameColumn];
    username = json[userUsernameColumn];
    cpfNumber = json[userCpfColumn];
    birthdate = json[userBirthdateColumn];
    phoneNumber = json[userPhoneColumn];
    password = json[userPasswordColumn];
  }

  Map<String, dynamic> toMapDB() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[userIdColumn] = id;
    data[userNameColumn] = name;
    data[userUsernameColumn] = username;
    data[userCpfColumn] = cpfNumber;
    data[userBirthdateColumn] = birthdate;
    data[userPhoneColumn] = phoneNumber;
    data[userPasswordColumn] = password;
    return data;
  }

  static fromJson(Map<String, dynamic> json) {}
}
