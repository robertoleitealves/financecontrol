import '../../../db/database_provider_tg.dart';
import '../../../model/credit_card_model.dart';
import '../../../model/expenses_model.dart';
import '../../../model/user_model.dart';

class ExpensesRepository {
  final _helper = DatabaseProvider();

  Future<UserModel> getUserModelDB() async {
    return await _helper.getUserDb();
  }


  Future saveExpensesByCreditCard({
    required int creditCardId,
    required ExpensesModel expense,
  }) async {
    expense.idCreditCard = creditCardId;
    await _helper.saveExpenseDB(expense);
  }

  // PRODUCER
  Future<int> saveNewCreditCardDB(CreditCardModel creditCard) async {
    return await _helper.saveCreditCardDB(creditCard);
  }

  Future<int> updateCreditCardDb(CreditCardModel creditCard) async {
    return await _helper.updateCreditCardDb(creditCard);
  }

  Future<int> deleteCreditCardDb(int creditCardId) async {
    await _helper.deleteAllExpensesByCreditCardDb(creditCardId);
    return await _helper.deleteCreditCardDb(creditCardId);
  }

  // FARM
  Future<int> saveNewExpenseDB(ExpensesModel expense) async {
    return await _helper.saveExpenseDB(expense);
  }

  Future<int> updateExpenseDb(ExpensesModel expense) async {
    return await _helper.updateExpenseDb(expense);
  }

  Future<int> deleteExpenseDb(int expenseId) async {
    return await _helper.deleteExpensesDb(expenseId);
  }


}
