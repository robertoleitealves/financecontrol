import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../db/database_provider_tg.dart';
import '../../../model/user_model.dart';
import '../../../routes/app_routes.dart';
import '../../../services/utils_services.dart';
import '../../base/controller/data_controller.dart';
import '../../base/controller/navigation_controller.dart';
import '../../creditcard/controller/creditcard_controller.dart';
import '../../expenses/controller/expenses_controller.dart';
import '../repository/auth_repository.dart';
import '../result/auth_result.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;

  final helper = DatabaseProvider();
  final authRepository = AuthRepository();
  final utilServices = UtilsServices();
  final TextEditingController nameLoginController = TextEditingController();
  String? nameLogin;
  String? passwordLogin;
  final TextEditingController passwordLoginController = TextEditingController();
  UserModel user = UserModel();

  // SIGNUP CONTROLLERS
  final passwordController = TextEditingController();
  final nameSignUpController = TextEditingController();
  final passwordSignUpController = TextEditingController();
  final passwordConfirmController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final birthdateController = TextEditingController();
  final cpfSignUpController = TextEditingController();

  // @override
  // void onInit() {
  //   super.onInit();
  //   // validateToken();
  // }

  // QUANDO INICIALIZAR O APLICATIVO FAZ A VERIFICAÇÃO
  // Future<void> validateToken() async {
  //   // Recuperar o token que foi salvo localmente
  //   String? token = await utilServices.getLocalData(key: StorageKeys.token);
  //   if (token == null) {
  //     Get.offAllNamed(PagesRoute.signInRoute);
  //     return;
  //   } else {
  //     loadData();
  //   }
  // }

  loadData() async {
    Get.lazyPut(() => ExpensesController());
    Get.lazyPut(() => CreditCardController());
    Get.lazyPut(() => NavigationController());
    Get.lazyPut(() => DataController());
  }

  // RESETAR SENHA
  Future resetPassword(UserModel user, String cpfNumber) async {
    isLoading.value = true;
    final result = await authRepository.resetPassword(user, cpfNumber);
    isLoading.value = false;

    if (result >= 1) {
      return 'Senha alterada com sucesso';
    } else {
      return 'Erro ao alterar senha';
    }
  }

  // DESLOGAR DO APLICATIVO
  Future<void> signOut() async {
    // Zerar o user
    user = UserModel();

    // Apagar todos os dados do controller
    clearAuthController(userModelToo: true);
    // Ir para o login
    Get.offAllNamed(PagesRoute.signInRoute);
  }

  // CADASTRAR USUÁRIO
  Future<void> signUp() async {
    isLoading.value = true;
    user.cpfNumber = cpfSignUpController.text;
    user.birthdate = birthdateController.text;
    user.name = nameSignUpController.text;
    user.password = passwordSignUpController.text;
    user.phoneNumber = phoneNumberController.text;
    AuthResult result = await authRepository.signUp(user);
    result.when(
      success: (authResponse) async {
        clearAuthController();

        utilServices.showToast(
            message: "Conta criada e logada com sucesso!", isSuccess: true);
        await loadData();
        Get.toNamed(PagesRoute.baseRoute);
      },
      error: (message) {
        utilServices.showToast(
            message: 'Usuário e/ou senha incorretos!', isError: true);
      },
    );

    isLoading.value = false;
  }

  // LOGAR USUÁRIO
  Future<void> signIn() async {
    isLoading.value = true;
    nameLogin = nameLoginController.text;
    passwordLogin = passwordLoginController.text;
    AuthResult result = await authRepository.signin(
        nameUser: nameLogin!, password: passwordLogin!);
    isLoading.value = false;
    result.when(
      success: (authResponse) async {
        try {
          user = UserModel.fromMapDB(authResponse);
          await loadData();
          Get.toNamed(PagesRoute.baseRoute);
        } catch (err) {
          Get.snackbar('Erro database', err.toString());
        }

        // saveTokenAndProceedToBase();
      },
      error: (message) {
        utilServices.showToast(message: message, isError: true);
      },
    );
  }

  // Zerar USER
  void clearAuthController({bool userModelToo = false}) {
    if (userModelToo) {
      user = UserModel();
    }

    passwordSignUpController.clear();
    passwordConfirmController.clear();
    nameSignUpController.clear();
    phoneNumberController.clear();
    birthdateController.clear();
    cpfSignUpController.clear();
  }

  // // APAGAR DADOS DO BD RELACIONADO AO USER
  // void clearDbDataSignOut() async {
  //   await helper.deleteDbTablesSignOut();
  // }

  // FINALIZE USER
  void finalizeUserModel() {
    user.password = passwordController.text;
    user.name = nameSignUpController.text;
    user.phoneNumber = phoneNumberController.text;
    user.birthdate = birthdateController.text;
    user.cpfNumber = cpfSignUpController.text;

    signUp();
  }
}
