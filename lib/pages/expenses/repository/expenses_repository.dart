import 'dart:developer';

import 'package:financecontrol/pages/auth/controller/auth_controller.dart';
import 'package:get/get.dart';

import '../../../db/database_provider_tg.dart';
import '../../../model/credit_card_model.dart';
import '../../../model/expenses_model.dart';
import '../../../model/user_model.dart';

class ExpensesRepository {
  final _helper = DatabaseProvider();
  final _authController = Get.find<AuthController>();

  Future<UserModel> getUserModelDB(String username) async {
    return await _helper.getUserDb();
  }

  Future saveExpensesByCreditCard({
    required int creditCardId,
    required ExpensesModel expense,
  }) async {
    expense.idCreditCard = creditCardId;
    await _helper.saveExpenseDB(expense);
  }

  Future<List<CreditCardModel>> getCreditCardByUserIdDb(int userId) async {
    try {
      final result =
          await _helper.getCreditCardByIdUserDb(_authController.user!.id!);
      if (result.isNotEmpty) {
        return result;
      } else {
        return <CreditCardModel>[];
      }
    } catch (e, s) {
      log("Erro", error: e, stackTrace: s);
      return [];
    }
  }

  Future<CreditCardModel> getCreditCardByCreditCardId(int creditCardId) async {
    try {
      final result = await _helper.getCreditCardByIdCreditCardDb(creditCardId);
      return result;
    } catch (e, s) {
      log("Erro", error: e, stackTrace: s);
      return CreditCardModel();
    }
  }

  Future<List<ExpensesModel>> getExpensesByCreditCardIdDb(
      int creditCardId) async {
    try {
      final result = await _helper.getExpensesByIdCreditCardDb(creditCardId);
      if (result.isNotEmpty) {
        return result;
      } else {
        return <ExpensesModel>[];
      }
    } catch (e, s) {
      log("Erro", error: e, stackTrace: s);
      return [];
    }
  }

  // EXPENSES

  Future<List<ExpensesModel>> getExpensesByUserIdDb(int userId) async {
    try {
      final result =
          await _helper.getExpensesByIdUserDb(_authController.user!.id!);
      if (result.isNotEmpty) {
        return result;
      } else {
        return <ExpensesModel>[];
      }
    } catch (e, s) {
      log("Erro", error: e, stackTrace: s);
      return [];
    }
  }

  Future<int> saveNewExpenseDB(ExpensesModel expense) async {
    return await _helper.saveExpenseDB(expense);
  }

  Future<int> updateExpenseDb(ExpensesModel expense) async {
    return await _helper.updateExpenseDb(expense);
  }

  Future<int> deleteExpenseDb(int expenseId) async {
    return await _helper.deleteExpensesDb(expenseId);
  }

  Future<int> updateCreditCardDb(CreditCardModel creditCard) async {
    return await _helper.updateCreditCardDb(creditCard);
  }
}
