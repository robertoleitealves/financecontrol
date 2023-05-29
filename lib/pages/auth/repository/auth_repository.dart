import 'dart:convert';

import 'package:financecontrol/pages/auth/controller/auth_controller.dart';
import 'package:get/get.dart';

import '../../../db/database_provider_tg.dart';
import '../../../model/user_model.dart';
import '../result/auth_result.dart';

class AuthRepository {
  final DatabaseProvider _helper = DatabaseProvider();
  // final HttpManager _httpManager = HttpManager();



  // LOGAR
  Future<AuthResult> signin(
      {required String nameUser, required String password}) async {
    // String encodedPassword = base64.encode(utf8.encode(password));

    try {
      final response = await _helper.signIn(nameUser, password);

      return AuthResult.success(response.last);
    } catch (e) {
      return AuthResult.error(e.toString());
    }
  }

  // CADASTRAR
  Future<AuthResult> signUp(UserModel user) async {
    String encodedPassword = base64.encode(utf8.encode(user.password!));

    try {
      final auxUser = user.toMapDB();
      auxUser['userPassword'] = encodedPassword;
      final id = await _helper.saveUserDb(user);
      user.idUser = id;
      Get.put(() => AuthController());
      return AuthResult.success(Response);
    } catch (e) {
      return AuthResult.error(e.toString());
    }
  }

  // REDEFINIR SENHA
  Future<int> resetPassword(UserModel user, String cpfNumber) async {
    final result = await _helper.updateUserDb(user, cpfNumber);
    return result;
  }
}
