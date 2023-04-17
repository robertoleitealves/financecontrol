// ignore_for_file: public_member_api_docs, sort_constructors_first
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
}
