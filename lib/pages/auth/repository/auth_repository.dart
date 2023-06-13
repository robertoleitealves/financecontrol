import 'dart:convert';

import 'package:financecontrol/model/user_auth_model.dart';
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
      {required String username, required String password}) async {
    

    try {
      final response = await _helper.signIn(username, password);

      return AuthResult.success(response.user);
    } catch (e) {
      return AuthResult.error(e.toString());
    }
  }

  Future getUserById(int id) async {
    final result = await _helper.getUserByIdDb(id);
    try {
      return AuthResult.success(result);
    } catch (e) {
      return AuthResult.error('Erro ao carregar o usuário');
    }
  }

  // CADASTRAR
  Future<AuthResult> signUp(UserModel user, UserAuthModel authUser) async {
    String encodedPassword = base64.encode(utf8.encode(user.password!));

    try {
      final auxUser = user.toMapDB();
      final auxAuthUser = authUser.toMapDB();
      auxUser['password'] = encodedPassword;
      auxAuthUser['password'] = encodedPassword;
      final id = await _helper.saveUserDb(user);
      final idAuth = await _helper.saveAuthDb(authUser);
      authUser.id = idAuth;
      user.id = id;

      Get.put(() => AuthController());
      return AuthResult.success(Response);
    } catch (e) {
      return AuthResult.error(e.toString());
    }
  }

  // REDEFINIR SENHA
  Future<int> resetPassword(UserModel username, String cpfNumber) async {
    final result = await _helper.updateUserDb(username, cpfNumber);
    return result;
  }
}
