import 'dart:developer';

import 'package:financecontrol/pages/creditcard/controller/creditcard_controller.dart';
import 'package:financecontrol/services/utils_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../model/credit_card_model.dart';
import '../../../model/expenses_model.dart';
import '../../../model/user_model.dart';
import '../repository/expenses_repository.dart';

class ExpensesController extends GetxController {
  final utilsServices = UtilsServices();
  final ScrollController expenseController = ScrollController();
  final ScrollController creditController = ScrollController();
  final _repository = ExpensesRepository();
  final creditCardController = Get.find<CreditCardController>();
  double? totalValue = 0.00;
  RxBool isLoading = false.obs;
  RxList<ExpensesModel> listExpenses = <ExpensesModel>[].obs;
  RxList<CreditCardModel> listCreditCard = <CreditCardModel>[].obs;
  final RxList<CreditCardModel> creditCardList = <CreditCardModel>[].obs;
  Rx<ExpensesModel>? selectedExpense;
  UserModel user = UserModel();

  //CADASTRO DE DESPESAS
  final TextEditingController marketController = TextEditingController();
  final TextEditingController installmentsController = TextEditingController();
  final TextEditingController purchaseController = TextEditingController();
  final expenseFormKey = GlobalKey<FormState>();
  Rx<CreditCardModel>? creditSelected;
  Rx<ExpensesModel>? expense;
  RxList<ExpensesModel> expenseList = <ExpensesModel>[].obs;
  ExpensesModel? expenseModel;
  RxDouble sumExpenses = 0.00.obs;
  int? idCredit;
  double newLimit = 0.00;

// --------------- CREATE EXPENSES -------------------- //

  @override
  onInit() {
    super.onInit();
    getExpenses();
  }

  void clearExpensesControllers() {
    marketController.clear();
    installmentsController.clear();
    purchaseController.clear();
  }

  selectedCard(CreditCardModel cardSelect) {
    idCredit = cardSelect.id!;
    creditSelected = cardSelect.obs;
  }

  getExpenses() async {
    isLoading.value = true;
    sumExpenses = 0.00.obs;
    // user = await _repository.getUserModelDB();
    listExpenses.value = await _repository.getExpensesByUserIdDb(user.id!);
    expenseList = listExpenses;
    for (ExpensesModel expense in expenseList) {
      sumExpenses.value = sumExpenses.value + expense.purchaseValue;
      expense.creditCard =
          await _repository.getCreditCardByCreditCardId(expense.idCreditCard);
    }

    isLoading.value = false;
    update();
  }

  void onExpenseSelect(ExpensesModel expense) async {
    isLoading.value = true;
    selectedExpense?.value = expense;
    selectedExpense?.value.creditCard =
        await _repository.getCreditCardByCreditCardId(expense.idCreditCard);
    isLoading.value = false;
    update();
  }

  updateCreditCard(
      CreditCardModel creditCard, ExpensesModel expenseSelect) async {
    newLimit = creditCard.avaliableLimit! - expenseSelect.purchaseValue;
    creditCard.avaliableLimit = newLimit;
    final result = await _repository.updateCreditCardDb(creditCard);
    // await creditCardController.getCreditCard();
    update();
    return result;
  }

  Future<void> deleteExpenseDb(int expenseId) async {
    try {
      await _repository.deleteExpenseDb(expenseId);
      listExpenses.removeWhere((expense) => expense.id == expenseId);
      utilsServices.showToast(message: 'Despesa excluída com sucesso!');
      final expenseValue = selectedExpense?.value;
      await updateCreditCardDeleteExpenses(
          selectedExpense!.value.idCreditCard, expenseValue!);

      update();
      Get.back();
    } on Exception catch (e, s) {
      log('Erro ao deletar', name: 'deleteExpenseDb', error: e, stackTrace: s);
    }
    update();
  }

  updateCreditCardDeleteExpenses(
      int idCreditCard, ExpensesModel expense) async {
    CreditCardModel creditCard =
        await _repository.getCreditCardByCreditCardId(idCreditCard);
    creditCard.avaliableLimit =
        creditCard.avaliableLimit! + expense.purchaseValue;
    creditCard.quantityExpenses = creditCard.quantityExpenses! - 1;
    final result = await _repository.updateCreditCardDb(creditCard);
    update();
    return result;
  }

  void slaughterplot(ExpensesModel expense) async {
    expense.installments = expense.installments - 1;
    await _repository.updateExpenseDb(expense);
    update();
  }

  void saveExpense() async {
    if (expenseFormKey.currentState!.validate()) {
      isLoading.value = true;
      expenseModel?.market = marketController.text;
      expenseModel?.purchaseValue = double.parse(purchaseController.text);
      expenseModel?.installments = int.parse(installmentsController.text);
      expenseModel?.creditCard = creditSelected!.value;
      expenseModel?.idCreditCard = idCredit!;
      // expenseModel?.user = await _repository.getUserModelDB();
      expenseModel?.idUser = expenseModel!.user.id!;
      expenseModel?.createdAt = DateTime.now().toString();
      expenseList.add(expenseModel!);
      sumExpenses.value = sumExpenses.value + expenseModel!.purchaseValue;
      creditSelected!.value.quantityExpenses =
          creditSelected!.value.quantityExpenses! + 1;
      expenseModel?.id = await _repository.saveNewExpenseDB(expenseModel!);
      await updateCreditCard(creditSelected!.value, expenseModel!);

      update();
      isLoading.value = false;
      clearExpensesControllers();
      // getExpenses();
      Get.back();
    }
  }

  void deleteExpense(ExpensesModel expense) async {
    try {
      await _repository.deleteExpenseDb(expense.id);
      listExpenses
          .removeWhere((expenseSelected) => expenseSelected.id == expense.id);
      utilsServices.showToast(message: 'Despesa excluída com sucesso!');
      await updateCreditCardDeleteExpenses(expense.idCreditCard, expense);
      await getExpenses();
    } on Exception catch (e, s) {
      log('Erro ao deletar',
          name: 'deleteCreditCardDb', error: e, stackTrace: s);
    }
    update();
  }
}
