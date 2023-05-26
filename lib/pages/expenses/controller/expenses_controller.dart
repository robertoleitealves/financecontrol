import 'dart:developer';

import 'package:financecontrol/services/utils_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../model/credit_card_model.dart';
import '../../../model/expenses_model.dart';
import '../../../model/user_model.dart';
import '../../auth/controller/auth_controller.dart';
import '../repository/expenses_repository.dart';

class ExpensesController extends GetxController {
  final utilsServices = UtilsServices();
  final ScrollController expenseController = ScrollController();
  final ScrollController creditController = ScrollController();
  final _repository = ExpensesRepository();
  double? totalValue = 0.00;

  RxList<ExpensesModel> listExpenses = <ExpensesModel>[].obs;
  RxList<CreditCardModel> listCreditCard = <CreditCardModel>[].obs;
  final RxList<CreditCardModel> creditCardList = <CreditCardModel>[].obs;
  Rx<ExpensesModel> selectedExpense = ExpensesModel().obs;
  UserModel user = UserModel();
  final _authController = Get.find<AuthController>();
  final TextEditingController marketController = TextEditingController();
  final TextEditingController creditCardController = TextEditingController();
  final TextEditingController installmentsController = TextEditingController();
  final TextEditingController purchaseController = TextEditingController();
  final expenseFormKey = GlobalKey<FormState>();
  Rx<CreditCardModel>? creditSelected;
  RxList<ExpensesModel> expenseList = <ExpensesModel>[].obs;
  // RxList<CreditCardModel> creditList = <CreditCardModel>[].obs;
  ExpensesModel expenseModel = ExpensesModel();

// --------------- CREATE EXPENSES -------------------- //

  void clearExpensesControllers() {
    marketController.clear();
    creditCardController.clear();
    installmentsController.clear();
    purchaseController.clear();
  }

  @override
  onInit() {
    getExpenses();
    getCredit();
  }

  selectedCard(CreditCardModel cardSelect) {
    creditSelected = cardSelect.obs;
  }

  getExpenses() async {
    listExpenses.value =
        await _repository.getExpensesByUserIdDb(_authController.user.idUser!);
    expenseList = listExpenses;
    update();
  }

  getCredit() async {
    creditCardList.value =
        await _repository.getCreditCardByUserIdDb(_authController.user.idUser!);
  }

  Future<void> deleteExpenseDb(int expenseId) async {
    try {
      await _repository.deleteExpenseDb(expenseId);
      listExpenses.removeWhere((expense) => expense.idExpense == expenseId);
      utilsServices.showToast(message: 'Despesa excluída com sucesso!');
    } on Exception catch (e, s) {
      log('Erro ao deletar', name: 'deleteExpenseDb', error: e, stackTrace: s);
    }
    update();
  }

  void saveExpense() async {
    if (expenseFormKey.currentState!.validate()) {
      expenseModel.market = marketController.text;
      expenseModel.purchaseValue = double.parse(purchaseController.text);
      expenseModel.installments = int.parse(installmentsController.text);
      expenseModel.creditCard = creditSelected!.value;
      expenseModel.user = await _repository.getUserModelDB();
      expenseModel.idUser = expenseModel.user?.idUser;
      expenseModel.createdAt = DateTime.now().toString();
      listExpenses.add(expenseModel);
      _repository.saveNewExpenseDB(expenseModel);

      update();
      clearExpensesControllers();
      Get.back();
    }
  }

  Future<void> deleteCreditCardDb(int creditCardId) async {
    try {
      await _repository.deleteCreditCardDb(creditCardId);
      listExpenses.removeWhere((credit) => credit.idCreditCard == creditCardId);
      utilsServices.showToast(message: 'Cartão excluído com sucesso!');
    } on Exception catch (e, s) {
      log('Erro ao deletar',
          name: 'deleteCreditCardDb', error: e, stackTrace: s);
    }
    update();
  }

  // calcTotal() {
  //   totalValue =
  //       expenses[0]['value'] + expenses[1]['value'] + expenses[2]['value'].obs;
  // }
}
