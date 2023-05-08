// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../database/db_constants.dart';

class UserModel {
  String? name;
  String? cpfNumber;
  String? birthdate;
  String? phoneNumber;
  String? password;

  UserModel(
      {this.name,
      this.cpfNumber,
      this.birthdate,
      this.phoneNumber,
      this.password});

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json[userNameColumn];
    cpfNumber = json[userCpfColumn];
    birthdate = json[userBirthdateColumn];
    phoneNumber = json[userPhoneColumn];
    password = json[userPasswordColumn];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[userNameColumn] = name;
    data[userCpfColumn] = cpfNumber;
    data[userBirthdateColumn] = birthdate;
    data[userPhoneColumn] = phoneNumber;
    data[userPasswordColumn] = password;
    return data;
  }
}
