// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../database/db_constants.dart';

class UserModel {
  int? idUser;
  String? nameUser;
  String? dateOfBirth;
  String? cpfNumber;
  String? phoneNumber;
  String? passwordUser;
  UserModel({
    this.idUser,
    this.nameUser,
    this.dateOfBirth,
    this.cpfNumber,
    this.phoneNumber,
    this.passwordUser,
  });

  @override
  String toString() {
    return 'UserModel(idUser: $idUser, nameUser: $nameUser, dateOfBirth: $dateOfBirth, cpfNumber: $cpfNumber, phoneNumber: $phoneNumber, passwordUser: $passwordUser)';
  }

  Map<String, dynamic> toMapDB() {
    return <String, dynamic>{
      userIdColumn: idUser,
      userNameColumn: nameUser,
      userBirthdateColumn: dateOfBirth,
      userPhoneColumn: phoneNumber,
      userCpfColumn: cpfNumber,
      userPasswordColumn: passwordUser
    };
  }

  UserModel.fromMapDB(Map<String, dynamic> map) {
    idUser = map[userIdColumn];
    nameUser = map[userNameColumn];
    dateOfBirth = map[userBirthdateColumn];
    phoneNumber = map[userPhoneColumn];
    passwordUser = map[userPasswordColumn];
    cpfNumber = map[userCpfColumn];
  }
}
