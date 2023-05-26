import 'dart:developer';

import 'package:financecontrol/model/credit_card_model.dart';
import 'package:financecontrol/pages/creditcard/repository/creditcard_repository.dart';
import 'package:financecontrol/services/validators.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../model/expenses_model.dart';
import '../../../../model/user_model.dart';
import '../../../../services/utils_services.dart';
import '../../auth/controller/auth_controller.dart';

class CreditCardController extends GetxController {
  final _authController = Get.find<AuthController>();

  final ScrollController creditController = ScrollController();
  final _repository = CreditCardRepository();
  final RxList<ExpensesModel> _expenseList = <ExpensesModel>[].obs;
  final _utilsServices = UtilsServices();

  final searchFieldController = TextEditingController();
  RxList<CreditCardModel> creditList = <CreditCardModel>[].obs;
  RxList<CreditCardModel> listCreditCard = <CreditCardModel>[].obs;
  final Rx<CreditCardModel> selectedCreditCard = CreditCardModel().obs;
  final RxBool isLoading = false.obs;
  final double sum = 0.00;
  double newLimit = 0.00;

  final RxBool _isCpf = true.obs;
  UserModel user = UserModel();
  // ------------- CREATE CREDITCARD ----------------------- //

  final TextEditingController nameCreditCardController =
      TextEditingController();
  final TextEditingController limitValueController = TextEditingController();
  final TextEditingController newLimitValueController = TextEditingController();
  final TextEditingController validateDateController = TextEditingController();
  CreditCardModel creditModel = CreditCardModel();
  final creditFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    getCreditCard();
  }

  getCreditCard() async {
    listCreditCard.value =
        await _repository.getCreditCardByUserIdDb(_authController.user.idUser!);
    creditList = listCreditCard;
    update();
  }

  bool get isCpf => _isCpf.value;

  updateCreditCard(CreditCardModel creditCard) async {
    newLimit = double.parse(newLimitValueController.text);
    creditCard.limitValueCard = newLimit;
    final result = await _repository.updateCreditCardDb(creditCard);
    update();
    return result;
  }

  void onCreditCardSelect(CreditCardModel creditCard) {
    selectedCreditCard.value = creditCard;
    selectedCreditCard.value.expenses ??= <ExpensesModel>[];
    _expenseList.assignAll(selectedCreditCard.value.expenses!);
    update();
  }

  // void changeMask(String? numbers) {
  //   if (numbers != null) {
  //     String newText = numbers.replaceAll(RegExp(r'[^\d]'), "");
  //     if (newText.length == 11) {
  //       newText = newText.substring(0, 3) +
  //           "." +
  //           newText.substring(3, 6) +
  //           "." +
  //           newText.substring(6, 9) +
  //           "-" +
  //           newText.substring(9, 11);
  //     } else if (newText.length == 14) {
  //       newText = newText.substring(0, 2) +
  //           "." +
  //           newText.substring(2, 5) +
  //           "." +
  //           newText.substring(5, 8) +
  //           "/" +
  //           newText.substring(8, 12) +
  //           "-" +
  //           newText.substring(12, 14);
  //     }
  //     _cpfCnpjController.value = _cpfCnpjController.value.copyWith(
  //       text: newText,
  //       selection: TextSelection.collapsed(offset: newText.length),
  //     );
  //   }
  // }

  String? validatorCPF(String? value) {
    if (value != null) {
      _isCpf.value = true;
      return Validators.cpfValidator(value);
    }
    return 'CPF obrigatório';
  }

  void saveCredit() async {
    if (creditFormKey.currentState!.validate()) {
      creditModel.nameCreditCard = nameCreditCardController.text.trim();
      creditModel.limitValueCard = double.parse(limitValueController.text);
      creditModel.avaliableLimitCard = double.parse(limitValueController.text);
      creditModel.validateDate = validateDateController.text;
      user = await _repository.getUserModelDB();
      creditModel.user = user;
      creditModel.idUser = user.idUser;
      creditModel.idCreditCard =
          await _repository.saveNewCreditCardDB(creditModel);
      print(creditModel);
      creditList.add(creditModel);
      update();
      // creditList.assignAll(_dataController.creditCardList);
      Get.back();
      clearCreditCardControllers();
      _utilsServices.showToast(
        message: "Cartão cadastrado com sucesso",
        isError: false,
      );
    } else {
      _utilsServices.showToast(
        message: "Todos os dados devem ser preenchidos",
        isError: true,
      );
    }
  }

  Future<void> deleteCreditCardDb(int creditCardId) async {
    try {
      await _repository.deleteCreditCardDb(creditCardId);
      creditList.removeWhere((credit) => credit.idCreditCard == creditCardId);
      _utilsServices.showToast(message: 'Cartão excluído com sucesso!');
    } on Exception catch (e, s) {
      log('Erro ao deletar',
          name: 'deleteCreditCardDb', error: e, stackTrace: s);
    }
    update();
  }

  void clearCreditCardControllers() {
    nameCreditCardController.clear();
    limitValueController.clear();
    validateDateController.clear();
  }
}
