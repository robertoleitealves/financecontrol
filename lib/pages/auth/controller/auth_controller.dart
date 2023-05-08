import 'dart:convert';

import 'package:financecontrol/database/db_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import '../../../model/user_model.dart';
import '../../../routes/app_routes.dart';
import '../../base/controller/navigation_controller.dart';

class AuthController extends GetxController {
  final nameController = TextEditingController();
  final cpfController = TextEditingController();
  final birthdateController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();
  final nameSignInController = TextEditingController();
  final passwordSignInController = TextEditingController();
  String? nameSignin;
  String? passwordSignin;
  UserModel? savedUser;
  UserModel user = UserModel();

  int? idUser;
  UserModel newUser = UserModel();

  //CRIAR NOVO USUÁRIO
  Future signUp() async {
    newUser = UserModel(
        name: nameController.text,
        birthdate: birthdateController.text,
        phoneNumber: phoneNumberController.text,
        cpfNumber: cpfController.text,
        password: passwordController.text);
    saveNewUser(newUser);
    nameController.text = '';
    birthdateController.text = '';
    phoneNumberController.text = '';
    cpfController.text = '';
    passwordController.text = '';
    passwordConfirmController.text = '';

    print("Usuário cadastrado com sucesso");
    return newUser;
  }

  //LOGIN
  Future signIn() async {
    nameSignin = nameSignInController.text;
    passwordSignin = passwordSignInController.text;
    savedUser = await getSavedUser();

    if (nameSignin == savedUser!.name &&
        passwordSignin == savedUser!.password) {
      print('Login efetuado com sucesso');
      print(savedUser);
      Get.put(NavigationController());
      Get.toNamed(PagesRoute.baseRoute);
    } else {
      print('Nome e/ou senha incorreta');
    }
  }

  Future<UserModel> getSavedUser() async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    String? jsonUser = preference.getString(userTable);
    print(jsonUser);

    Map<String, dynamic> mapUser = json.decode(jsonUser!);
    user = UserModel.fromJson(mapUser);
    print(mapUser);
    return user;
  }

  //ATUALIZAR SENHA
  Future updatePassword() async {}

  //DELETAR USUÁRIO
  Future deleteUser() async {}

  //SAVE USER
  Future saveNewUser(UserModel newUser) async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    //COLETA OS DADOS INSERIDOS E O CONVERTE EM JSON STRING
    preference.setString(userTable, json.encode(newUser));
  }
}
