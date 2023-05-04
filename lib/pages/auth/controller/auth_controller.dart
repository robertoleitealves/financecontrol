import 'package:financecontrol/database/db_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

import '../../../model/user_model.dart';

class AuthController extends GetxController {
  final nameController = TextEditingController();
  final cpfController = TextEditingController();
  final dataNascController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();

  int? idUser;
  UserModel? newUser;
  Map? nUser;

  //CRIAR NOVO USUÁRIO
  Future signUp() async {
    return nUser;
  }

  //LOGIN
  Future signIn() async {}

  //ATUALIZAR SENHA
  Future updatePassword() async{
  }

  //DELETAR USUÁRIO
  Future deleteUser() async{}
}
