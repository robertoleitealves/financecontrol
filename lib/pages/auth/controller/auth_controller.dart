import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../../constants/storage_keys.dart';
import '../../../db/database_provider_tg.dart';
import '../../../model/auth_response_model.dart';
import '../../../model/token_model.dart';
import '../../../model/user_model.dart';
import '../../../routes/app_routes.dart';
import '../../../services/utils_services.dart';
import '../repository/auth_repository.dart';
import '../result/auth_result.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;

  final helper = DatabaseProvider();
  final authRepository = AuthRepository();
  final utilServices = UtilsServices();
  // final connectivity = ConnectivityController();

  UserModel user = UserModel();
  Token? token;

  // SIGNUP CONTROLLERS
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmedController = TextEditingController();
  final nameController = TextEditingController();
  final passwordSignInController = TextEditingController();
  final passwordConfirmController = TextEditingController();
  final nameSignInController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final birthdateController = TextEditingController();
  final cpfController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    validateToken();
  }

  // QUANDO INICIALIZAR O APLICATIVO FAZ A VERIFICAÇÃO
  Future<void> validateToken() async {
    // Recuperar o token que foi salvo localmente
    String? token = await utilServices.getLocalData(key: StorageKeys.token);
    if (token == null) {
      InitialController().loadData();
      
      Get.offAllNamed(PagesRoute.signInRoute);
      return;
    }

    AuthResult result = await authRepository.validateToken(token);

    result.when(
      success: (authResponse) async {
        user = await helper.getUserDb();
        this.token = Token(type: 'Bearer', token: token);
        debugPrint('Token: $token');
        Get.offAllNamed(PagesRoute.baseRoute);
      },
      error: (message) {
        utilServices.showToast(message: "Login expirado");
        signOut();
      },
    );
  }

  // RESETAR SENHA
  Future<void> resetPassword(String email) async {
    isLoading.value = true;
    AuthResult result = await authRepository.resetPassword(email);
    isLoading.value = false;
    result.when(
      success: (response) {
        Get.back();
        // Get.snackbar('E-mail de Recuperaçao Enviado!',
        //     'Foi enviado um e-mail de verificação para o e-mail: ' + email,
        //     duration: const Duration(seconds: 8),
        //     snackPosition: SnackPosition.BOTTOM,
        //     backgroundColor: AppColors.primary,
        //     colorText: AppColors.textColorPrimary,
        //     margin: const EdgeInsets.all(4));
      },
      error: (message) {
        utilServices.showToast(message: message, isError: true);
      },
    );
  }

  // DESATIVAR USUÁRIO
  Future disableUser() async {
    isLoading.value = true;
    final response = await authRepository.disableUser(user.idUser!, token!.token);
    isLoading.value = false;
    return response;
  }

  // DESLOGAR DO APLICATIVO
  Future<void> signOut() async {
    // Zerar o user
    user = UserModel();

    // Remover o token localmente
    await utilServices.removeLocalData(key: StorageKeys.token);

    // Apagar todos os dados do controller
    clearAuthController(userModelToo: true);

    // Apaga todas as tabelas refente ao user do banco local
    // clearDbDataSignOut();

    // Ir para o login
    Get.offAllNamed(PagesRoute.signInRoute);
  }

  // CADASTRAR USUÁRIO
  Future<void> signUp() async {
    isLoading.value = true;
    AuthResult result = await authRepository.signUp(user);
    result.when(
      success: (authResponse) async {
        clearAuthController();
        await signIn();
        utilServices.showToast(
            message: "Conta criada e logada com sucesso!", isSuccess: true);
      },
      error: (message) {
        utilServices.showToast(message: message, isError: true);
      },
    );

    isLoading.value = false;
  }

  // LOGAR USUÁRIO
  Future<void> signIn() async {
    if (connectivity.isNotConnected) {
      isLoading.value = true;
      AuthResult result = await authRepository.signin(
          name: user.name!, password: user.password!);

      isLoading.value = false;

      result.when(
        success: (authResponse) async {
          try {
            await helper.saveUserDb(authResponse.user);

            await helper.saveTokenDb(
              TokenModel(
                token: authResponse.token.token,
                userId: authResponse.user.id,
              ),
            );
            debugPrint("Token: ${authResponse.token.token}");
          } catch (err) {
            Get.snackbar('Erro database', err.toString());
          }
          user = authResponse.user;
          token = authResponse.token;
          saveTokenAndProceedToBase();
        },
        error: (message) {
          utilServices.showToast(message: message, isError: true);
        },
      );
    } else {
      utilServices.showToast(
          message:
              "Você precisa estar conectado a internet. Verifique sua conexão e tente novamente.");
    }
  }

  // SALVAR TOKEN LOCAL
  void saveTokenAndProceedToBase() {
    // Salvar o token
    utilServices.saveLocalData(key: StorageKeys.token, data: token!.token);
    // Ir para a base
    Get.offAllNamed(PagesRoute.baseRoute);
  }

  // Zerar USER
  void clearAuthController({bool userModelToo = false}) {
    if (userModelToo) {
      user = UserModel();
    }

    passwordController.clear();
    passwordConfirmedController.clear();

    nameController.clear();
    phoneNumberController.clear();
    birthdateController.clear();
    cpfController.clear();
  }

  // // APAGAR DADOS DO BD RELACIONADO AO USER
  // void clearDbDataSignOut() async {
  //   await helper.deleteDbTablesSignOut();
  // }

  // FINALIZE USER
  void finalizeUserModel() {
    user.password = passwordController.text;
    user.name = nameController.text;
    user.phoneNumber = phoneNumberController.text;
    user.birthdate = birthdateController.text;
    user.cpfNumber = cpfController.text;

    signUp();
  }
}
