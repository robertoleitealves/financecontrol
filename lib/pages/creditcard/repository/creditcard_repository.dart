import '../../../database/database_provider.dart';
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
    List<ExpensesModel> cultureList = await _helper.getExpensesListDb();
    return cultureList.where((expense) => expense.idExpense == expenseId).first;
  }

  Future<List<ExpensesModel>> getExpenses() async {
    return await _helper.getExpensesListDb();
  }

  Future saveExpenseByCreditCard({
    required int creditCardId,
    required ExpensesModel expense,
  }) async {
    expense.idCreditCard = creditCardId;
    await _helper.saveExpensesDB(expense);
  }

  // CREDITCARD
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
    return await _helper.saveExpensesDB(expense);
  }

  Future<int> updateExpenseDb(ExpensesModel expense) async {
    return await _helper.updateExpensesDb(expense);
  }

  Future<int> deleteExpenseDb(int expenseId) async {
    return await _helper.deleteExpenseDb(expenseId);
  }

 
}