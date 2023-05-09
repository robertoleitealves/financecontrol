import 'package:flutter/material.dart';

import '../../../db/database_provider_tg.dart';
import '../../../model/credit_card_model.dart';
import '../../../model/expenses_model.dart';
import '../../../model/token_model.dart';
import '../../../model/user_model.dart';

class DataRepository {
  final DatabaseProvider _helper = DatabaseProvider();

  Future<String> getTokenDb() async {
    TokenModel token = await _helper.getTokenDb();
    return token.token!;
  }

  Future<UserModel> getUserModelDB() async {
    return await _helper.getUserDb();
  }

  Future<void> saveCreditCardsListDb(List<CreditCardModel> list) async {
    try {
      await _helper.insertCreditCardsDb(list);
    } catch (err) {
      debugPrint("SaveCreditCardListDb: ${err.toString()}");
    }
  }

  Future<List<CreditCardModel>> getCreditCardsListDb() async {
    try {
      return await _helper.getCreditCardListDb();
    } catch (err) {
      debugPrint("getCreditCardsListDb: ${err.toString()}");
      return <CreditCardModel>[];
    }
  }

  Future<void> saveExpensesListDb(List<ExpensesModel> list) async {
    try {
      await _helper.insertExpenseDb(list);
    } catch (err) {
      debugPrint("SaveExpensesListDb: ${err.toString()}");
    }
  }

  Future<List<ExpensesModel>> getExpensesListDb() async {
    try {
      return await _helper.getExpensesListDb();
    } catch (err) {
      debugPrint("getExpensesListDb: ${err.toString()}");
      return <ExpensesModel>[];
    }
  }

  Future<void> updateCreditCardDb(CreditCardModel creditCard) async {
    try {
      await _helper.updateCreditCardDb(creditCard);
    } catch (e) {
      debugPrint("updateCreditCardDb: erro $e");
    }
  }

  Future<void> updateExpensesDb(ExpensesModel expense) async {
    try {
      await _helper.updateExpenseDb(expense);
    } catch (e) {
      debugPrint("updateProducerDb: erro $e");
    }
  }
}
