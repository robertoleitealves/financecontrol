import 'package:flutter/material.dart';


import '../../../../database/database_provider.dart';
import '../../../../model/credit_card_model.dart';
import '../../../../model/expenses_model.dart';
import '../../../../model/user_model.dart';

class DataRepository {
  final DatabaseProvider _helper = DatabaseProvider();

  Future<String> getTokenDb() async {
    TokenModel token = await _helper.getTokenDb();
    return token.token!;
  }

  Future<UserModel> getUserModelDB() async {
    return await _helper.getUserDb();
  }

  Future<void> saveCreditCardListDb(List<CreditCardModel> list) async {
    try {
      await _helper.insertCreditCardDb(list);
    } catch (err) {
      debugPrint("SaveCreditCardListDb: ${err.toString()}");
    }
  }

  Future<List<CreditCardModel>> getCreditCardListDb() async {
    try {
      return await _helper.getCreditCardsListDb();
    } catch (err) {
      debugPrint("getCreditCardsListDb: ${err.toString()}");
      return <CreditCardModel>[];
    }
  }

  Future<void> saveExpensesListDb(List<ExpensesModel> list) async {
    try {
      await _helper.insertExpensesDb(list);
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

  Future<void> updateExpenseDb(ExpensesModel expense) async {
    try {
      await _helper.updateExpensesDb(expense);
    } catch (e) {
      debugPrint("updateProducerDb: erro $e");
    }
  }


}
