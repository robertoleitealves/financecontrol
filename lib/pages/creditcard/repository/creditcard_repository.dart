
import '../../../db/database_provider_tg.dart';
import '../../../model/credit_card_model.dart';
import '../../../model/expenses_model.dart';
import '../../../model/user_model.dart';

class ProducerRepository {
  final _helper = DatabaseProvider();

  Future<UserModel> getUserModelDB() async {
    return await _helper.getUserDb();
  }

  //EXPENSES
  Future<ExpensesModel> getExpenseByExpenseId(int expenseId) async {
    List<ExpensesModel> expenseList = await _helper.getExpensesListDb();
    return expenseList.where((expense) => expense.idExpense == expenseId).first;
  }

  Future<List<ExpensesModel>> getExpenses() async {
    return await _helper.getExpensesListDb();
  }

  Future saveExpenseByCreditCard({
    required int creditCardId,
    required ExpensesModel expense,
  }) async {
    expense.idCreditCard = creditCardId;
    await _helper.saveExpenseDB(expense);
  }

  // CREDITCARD
  Future<int> saveNewCreditCardDB(CreditCardModel creditCard) async {
    return await _helper.saveCreditCardDB(creditCard);
  }

  Future<int> updateCreditCardDb(CreditCardModel creditCard) async {
    return await _helper.updateCreditCardDb(creditCard);
  }

  Future<int> deleteCreditCardDb(int creditCardId) async {
    await deleteAllExpensesByCreditCardDb(creditCardId);
    return await _helper.deleteCreditCardDb(creditCardId);
  }

  Future<int> deleteAllExpensesByCreditCardDb(int creditCardId) async {
    List<ExpensesModel> expenseList = await getExpenses();
    expenseList.removeWhere((expense) => expense.idCreditCard != creditCardId);
    var qtde = 0;
    for (ExpensesModel expense in expenseList) {
      await deleteExpenseDb(expense.idExpense!);
      qtde++;
    }
    return qtde;
  }

  // EXPENSE
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
