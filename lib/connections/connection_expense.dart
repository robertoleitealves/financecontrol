import 'package:financecontrol/model/expenses_model.dart';

abstract class ExpensesDAO {
  saveExpense(ExpensesModel expense);

  removeExpense(int idExpense);

  Future<List<ExpensesModel>> findExpense();
}
