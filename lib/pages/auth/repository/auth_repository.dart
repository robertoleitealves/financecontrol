import 'dart:convert';
import 'dart:developer';

import 'package:financecontrol/pages/base/controller/data_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../db/database_provider_tg.dart';
import '../../../model/auth_response_model.dart';

import '../../../model/user_model.dart';
import '../result/auth_result.dart';

class AuthRepository {
  final DatabaseProvider _helper = DatabaseProvider();
  // final HttpManager _httpManager = HttpManager();

  // TRATATIVA DE RESPONSE USER
  AuthResult handleUserOrError(dynamic result) {
    if (result is Map<String, dynamic>) {
      if (result['token'] != null) {
        final user = AuthResponseModel.fromJson(result);
        return AuthResult.success(user);
      }

      final user = UserModel.fromJson(result);
      return AuthResult.success(user);
    } else if (result is int) {
      return AuthResult.error(result.toString());
    } else if (result.isEmpty) {
      return AuthResult.success(result);
    } else {
      debugPrint(result);
      return AuthResult.error(result);
    }
  }

  // TRATATIVA DE RESPONSE

  // LOGAR
  Future<AuthResult> signin(
      {required String nameUser, required String password}) async {
    // String encodedPassword = base64.encode(utf8.encode(password));

    try {
      final response = await _helper.signIn(nameUser, password);
      print(response);
      return AuthResult.success(response);
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
      await _helper.saveUserDb(user);
      Get.put(DataController());
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
