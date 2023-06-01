import 'package:financecontrol/constants/db_constants.dart';
import 'package:financecontrol/model/user_model.dart';

class UserAuthModel {
  int? id;
  String? username;
  String? password;
  UserModel? user;

  UserAuthModel({
    this.id,
    this.username,
    this.password,
  });

  UserAuthModel.fromMapDB(Map<String, dynamic> json) {
    id = json[authIdColumn];
    username = json[authUsernameColumn];
    password = json[authPasswordColumn];
  }

  Map<String, dynamic> toMapDB() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[authUsernameColumn] = username;
    data[authIdColumn] = id;
    data[authPasswordColumn] = password;

    return data;
  }
}
