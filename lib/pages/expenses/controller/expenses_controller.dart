import 'dart:developer';

import 'package:financecontrol/services/services/utils_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../model/credit_card_model.dart';
import '../../../model/expenses_model.dart';
import '../../../model/user_model.dart';
import '../../base/controller/data_controller.dart';
import '../repository/expenses_repository.dart';
import '../view/expense_screen.dart';

class ExpensesController extends GetxController {
  final utilsServices = UtilsServices();
  final ScrollController expenseController = ScrollController();
  final ScrollController creditController = ScrollController();
  final _dataController = Get.find<DataController>();
  final _repository = ExpensesRepository();
  double? totalValue = 0.00;
  List<Map> expenses = [
    {
      'idExpense': 01,
      'idCreditCard': 03,
      'idUser': 05,
      'market': 'Casa da Mãe Joana',
      'installments': 1,
      'purchaseValue': 50.00,
      'date': '2023-03-11'
    },
    {
      'idExpense': 01,
      'idCreditCard': 02,
      'idUser': 05,
      'market': 'Bar Joaquina',
      'installments': 3,
      'purchaseValue': 70.00,
      'date': '2023-03-18'
    },
    {
      'idExpense': 01,
      'idCreditCard': 03,
      'idUser': 05,
      'market': 'Savegnago',
      'installments': 1,
      'purchaseValue': 56.5,
      'date': '2023-04-20'
    }
  ];

  // ExpensesModel get selectedExpense => _selectedExpense.value;
  final RxList<ExpensesModel> listExpenses = <ExpensesModel>[].obs;
  final RxList<CreditCardModel> creditList = <CreditCardModel>[].obs;
  Rx<ExpensesModel> selectedExpense = ExpensesModel().obs;
  UserModel? user;

  //------------------ CREATE EXPENSE--------------------------------//

  final TextEditingController _marketController = TextEditingController();
  final TextEditingController _creditCardController = TextEditingController();
  final TextEditingController _installmentsController = TextEditingController();
  final TextEditingController _purchaseController = TextEditingController();
  final expenseFormKey = GlobalKey<FormState>();
  CreditCardModel creditSelected = CreditCardModel();
  List<CreditCardModel> get creditCardList => creditList;
  List<ExpensesModel> get expenseList => listExpenses;
  void onExpenseSelect(ExpensesModel expense) async {
    Get.to(
      () => ExpenseScreen(expense: expense),
      transition: Transition.fadeIn,
    );
  }

// --------------- CREATE EXPENSES -------------------- //

  void clearExpensesControllers() {
    _marketController.clear();
    _creditCardController.clear();
    _installmentsController.clear();
    _purchaseController.clear();
  }

  selectedCard(CreditCardModel cardSelect) async {}

  void saveExpense({ExpensesModel? expenseModel}) async {
    if (expenseFormKey.currentState!.validate()) {
      if (expenseModel != null) {
        expenseModel.market = _marketController.text;
        expenseModel.purchaseValue =
            double.parse(_purchaseController.text.trim());
        expenseModel.creditCard = creditSelected;
        expenseModel.user = user;
        expenseModel.idUser = user?.idUser;

        await _repository.updateExpenseDb(expenseModel);
        var index = listExpenses.indexWhere(
            (expense) => expense.idExpense == expenseModel.idExpense);
        listExpenses[index] = expenseModel;
        update();
        clearExpensesControllers();
        Get.back();
      } else {
        ExpensesModel expense = ExpensesModel();
        expense.market = _marketController.text.trim();
        expense.purchaseValue = double.parse(_purchaseController.text.trim());
        expense.creditCard = creditSelected;
        expense.installments = int.parse(_installmentsController.text.trim());
        expense.idUser = user?.idUser;

        expense.idExpense = await _repository.saveNewExpenseDB(expense);
        _dataController.expense.add(expense);
        clearExpensesControllers();
        update();
        selectedExpense.value = listExpenses.last;
        Get.back(result: expense);
      }
    }
  }

  Future<void> deleteExpensesDb(int expenseId) async {
    try {
      await _repository.deleteExpenseDb(expenseId);
      _dataController.expense
          .removeWhere((expense) => expense.idExpense == expenseId);
      // _expensesList.removeWhere((expense) => expense.id == expenseId);
      // openExpensesDetails(_selectedExpense.value);

      utilsServices.showToast(message: 'Despesa excluída com sucesso!');
      Get.back();
    } on Exception catch (e, s) {
      log('Erro ao deletar', name: 'deleteExpensesDb', error: e, stackTrace: s);
    }
  }

  // calcTotal() {
  //   totalValue =
  //       expenses[0]['value'] + expenses[1]['value'] + expenses[2]['value'].obs;
  // }
}
