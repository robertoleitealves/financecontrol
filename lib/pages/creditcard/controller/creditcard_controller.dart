import 'dart:developer';

import 'package:financecontrol/model/credit_card_model.dart';
import 'package:financecontrol/pages/creditcard/repository/creditcard_repository.dart';
// import 'package:financecontrol/services/validators.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../model/expenses_model.dart';
import '../../../../model/user_model.dart';
import '../../../../services/utils_services.dart';

class CreditCardController extends GetxController {
  final ScrollController creditController = ScrollController();
  final _repository = CreditCardRepository();

  final _utilsServices = UtilsServices();

  final searchFieldController = TextEditingController();
  RxList<CreditCardModel> creditList = <CreditCardModel>[].obs;
  RxList<CreditCardModel> listCreditCard = <CreditCardModel>[].obs;
  RxList<ExpensesModel>? listExpenses;
  Rx<CreditCardModel>? selectedCreditCard;
  final RxBool isLoading = false.obs;
  RxDouble sum = 0.00.obs;
  double newLimit = 0.00;
  RxInt qtExpenses = 0.obs;

  UserModel user = UserModel();
  // ------------- CREATE CREDITCARD ----------------------- //

  final TextEditingController nameCreditCardController =
      TextEditingController();
  final TextEditingController limitValueController = TextEditingController();
  final TextEditingController newLimitValueController = TextEditingController();
  final TextEditingController validateDateController = TextEditingController();
  CreditCardModel? creditModel;
  final creditFormKey = GlobalKey<FormState>();

  @override
  void onInit() async {
    super.onInit();
    getCreditCard();
    // user = await _repository.getUserModelDB();
  }

  getCreditCard() async {
    isLoading.value = true;
    sum = 0.00.obs;
    // user = await _repository.getUserModelDB();
    listCreditCard.value = await _repository.getCreditCardByUserIdDb(user.id!);
    creditList = listCreditCard;
    for (CreditCardModel credit in creditList) {
      sum.value = sum.value + credit.avaliableLimit!;
      listExpenses?.value =
          await _repository.getExpensesByCreditCardId(credit.id!);
      credit.expenses = listExpenses;
      if (listExpenses != null) {
        qtExpenses = listExpenses!.length.obs;
        if (qtExpenses < 0) {
          qtExpenses = 0.obs;
        }
      } else {
        qtExpenses = credit.quantityExpenses!.obs;
      }
    }

    isLoading.value = false;
    update();
  }

  updateCreditCard(CreditCardModel creditCard) async {
    newLimit = double.parse(newLimitValueController.text);
    creditCard.limitValue = newLimit;
    creditCard.avaliableLimit = newLimit;
    final result = await _repository.updateCreditCardDb(creditCard);

    await getCreditCard();
    update();
    return result;
  }

  void onCreditCardSelect(CreditCardModel creditCard) async {
    selectedCreditCard?.value = creditCard;
    await _repository.getCreditCardByCreditId(creditCard.id);

    update();
  }

  void saveCredit() async {
    if (creditFormKey.currentState!.validate()) {
      isLoading.value = true;
      creditModel = CreditCardModel(
        idUser: user.id!,
        name: nameCreditCardController.text,
        limitValue: double.parse(limitValueController.text),
        avaliableLimit: double.parse(limitValueController.text),
        validateDate: validateDateController.text,
        user: user,
        quantityExpenses: 0,
        id: await _repository.saveNewCreditCardDB(creditModel!),
      );

      await getCreditCard();

      isLoading.value = false;
      update();

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
      creditList.removeWhere((credit) => credit.id == creditCardId);
      _utilsServices.showToast(message: 'Cartão excluído com sucesso!');
    } on Exception catch (e, s) {
      log('Erro ao deletar',
          name: 'deleteCreditCardDb', error: e, stackTrace: s);
    }
    sum.value = sum.value - selectedCreditCard!.value.avaliableLimit!;
    update();
  }

  void clearCreditCardControllers() {
    nameCreditCardController.clear();
    limitValueController.clear();
    validateDateController.clear();
  }
}
