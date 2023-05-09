import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';

import '../../../db/database_provider_tg.dart';
import '../../../model/auth_response_model.dart';
import '../../../model/user_auth_model.dart';
import '../../../model/user_model.dart';
import '../result/auth_result.dart';

class AuthRepository {
  final DatabaseProvider _helper = DatabaseProvider();

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
      return AuthResult.error(authErrors(result));
    } else if (result.isEmpty) {
      return AuthResult.success(result);
    } else {
      debugPrint(authErrors(result));
      return AuthResult.error(authErrors(result));
    }
  }

  // LOGAR
  Future<AuthResult> signin(
      {required String name, required String password}) async {
    String encodedPassword = base64.encode(utf8.encode(password));

    try {
      Map body = UserAuthModel(
        nameUser: name,
        password: encodedPassword,
        identity: 1,
      ).toJson();

      // final result = await _httpManager.restRequest(
      //   url: Endpoints.signin,
      //   method: HttpMethods.post,
      //   body: body,
      // );

      return handleUserOrError(result);
    } on ErrorRequest catch (e) {
      return AuthResult.error(authErrors(e.statusCode));
    }
  }

  // // CADASTRAR
  Future<AuthResult> signUp(UserModel user) async {
    String encodedPassword = base64.encode(utf8.encode(user.password!));

    try {
      final auxUser = user.toMapDB();
      auxUser['password'] = encodedPassword;

      // final result = await _httpManager.restRequest(
      //   url: Endpoints.signup,
      //   method: HttpMethods.post,
      //   body: auxUser,
      // );

      return handleUserOrError(result);
    } on ErrorRequest catch (e) {
      return AuthResult.error(authErrors(e.statusCode));
    }
  }

  // REDEFINIR SENHA
  Future<AuthResult> resetPassword(String email) async {
    // final response = await _httpManager.restRequest(
    //   url: Endpoints.recoverPassword + "?email=$email",
    //   method: HttpMethods.post,
    //   body: {'email': email},
    // );

    return handleUserOrError(response);
  }

  // // DESATIVAR USUÁRIO
  Future disableUser(int userId, String token) async {
    try {
      // final response = await _httpManager.restRequest(
      //   url: Endpoints.disableUser + '?userId=$userId',
      //   method: HttpMethods.post,
      //   headers: {"Authorization": "Bearer $token"},
      // );
      return response;
    } on ErrorRequest catch (e) {
      log("Erro ao desativar usuário", name: 'disableUser', error: e);
    }
  }

  // BUSCAR USER DB LOCAL
  Future<UserModel> getUserDb() async {
    return await _helper.getUserDb();
  }
}
