import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../constants/db_constants.dart';
import '../model/credit_card_model.dart';
import '../model/expenses_model.dart';
import '../model/user_model.dart';

class DatabaseProvider {
  static final DatabaseProvider _instance = DatabaseProvider._init();
  factory DatabaseProvider() => _instance;
  Database? _db;
  DatabaseProvider._init();

  // Verifica se há algum Database já criado, se não, ele cria
  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    } else {
      _db = await initDb();
      return _db!;
    }
  }

  // START DATABASE
  initDb() async {
    // Get a location using getDatabasesPath
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'financial_control.db');
    // Abrindo um database
    Database myDb = await openDatabase(path,
        version: 1, onCreate: _onCreate, onUpgrade: _onUpgrade);
    return myDb;
  }

  // CLOSE DATABASE
  Future close() async {
    final db = await _instance.db;
    db.close();
  }

  // METHODS
  readData({
    required String table,
    List<String>? columns,
    String? where,
    List? whereargs,
  }) async {
    Database? mydb = await db;
    List<Map> response = await mydb.query(table,
        columns: columns, where: where, whereArgs: whereargs);
    return response;
  }

  insertData(String table, Map<String, dynamic> values) async {
    Database? mydb = await db;
    int response = await mydb.insert(table, values);
    return response;
  }

  updateData(String table, Map<String, dynamic> values,
      {String? where, List<Object>? args}) async {
    Database? mydb = await db;
    int response =
        await mydb.update(table, values, where: where, whereArgs: args);
    return response;
  }

  deleteData({required String table, String? where, List? whereargs}) async {
    Database? mydb = await db;
    int response = await mydb.delete(table, where: where, whereArgs: whereargs);
    return response;
  }

  // WHEN DB UPGRADE
  _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // TODO: FAZER UPGRADE DO BANCO DE DADOS
  }

  // CREATING TABLES
  _onCreate(Database db, int version) async {
    //const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL';

    // AUTH USER TABLE
    await db.execute('''
          CREATE TABLE $authUserTable (
            $authIdColumn INTEGER PRIMARY KEY,
            $authTokenUserIdColumn INTEGER,
            $authTokenColumn TEXT
          )
          ''');

    // USER TABLE
    await db.execute('''
          CREATE TABLE $userTable (
            $userIdColumn INTEGER PRIMARY KEY,
            $userNameColumn TEXT,
            $userCpfColumn TEXT,
            $userBirthdateColumn TEXT,
            $userPhoneColumn TEXT,
            $userPasswordColumn TEXT
 
          )
          ''');

    // EXPENSES TABLE
    await db.execute('''
            CREATE TABLE $expensesTable (
              $expenseIdColumn INTEGER PRIMARY KEY,
              $expenseMarketColumn TEXT NOT NULL,
              $expenseCreditCardIdColumn INTEGER,
              $expenseUserIdColumn INTEGER,
              $expenseInstallmentsColumn INTEGER,
              $expenseCreatedAtColumn TEXT,
              $expensePurchaseValueColumn REAL
        
            )
            ''');

    // CREDITCARD TABLE
    await db.execute('''
            CREATE TABLE $creditCardTable (
              $creditCardIdColumn INTEGER PRIMARY KEY,
              $creditCardUserIdColumn INTEGER,
              $creditCardNameColumn TEXT,
              $creditCardValidateDateColumn TEXT,
              $creditCardAvaliableLimitColumn REAL,
              $creditCardLimitValueColumn TEXT
             
            )
            ''');
  }
  // ---------------------- //

  // DELETE TABLES WHEN SIGN OUT
  // Future<void> deleteDbTablesSignOut() async {
  //   await deleteData(table: userTable);
  //   await deleteData(table: expensesTable);
  //   await deleteData(table: creditCardTable);

  // }

  // USER
  Future<int> saveUserDb(UserModel user) async {
    var id = await insertData(userTable, user.toMapDB());
    return id;
  }

  Future<UserModel> getUserDb() async {
    final result = await readData(table: userTable);
    UserModel response = UserModel.fromMapDB(result.first);

    return response;
  }

  Future signIn(String name, String password) async {
    final result = await readData(
        table: userTable,
        where: '$userNameColumn = ? AND $userPasswordColumn = ?',
        whereargs: [name, password]);
    return result;
  }

  Future<int> updateUserDb(UserModel user, String cpfNumber) async {
    int result = await updateData(userTable, user.toMapDB(),
        where: '$userCpfColumn = ?', args: [cpfNumber]);
    return result;
  }

  // // AUTH
  // Future<int> saveTokenDb(TokenModel tokenModel) async {
  //   await deleteData(table: authUserTable);
  //   return await insertData(authUserTable, tokenModel.toMapDb());
  // }

  // Future<TokenModel> getTokenDb() async {
  //   List result = await readData(table: authUserTable);
  //   return TokenModel.fromMapDb(result.first);
  // }

  // CREDIT CARDS
  Future<int> insertCreditCardsDb(List<CreditCardModel> values) async {
    Database myDb = await db;
    Batch batch = myDb.batch();

    for (var creditCards in values) {
      batch.insert(creditCardTable, creditCards.toMapDB());
    }

    await batch.commit(noResult: true);
    return 1;
  }

  Future<List<CreditCardModel>> getCreditCardListDb() async {
    final result = await readData(table: creditCardTable);
    List<CreditCardModel> creditCardList = result
        .map<CreditCardModel>(
            (producers) => CreditCardModel.fromMapDB(producers))
        .toList();
    return creditCardList;
  }

  Future<CreditCardModel?> getCreditCardByIdDb(int creditCardId) async {
    List result = await readData(
        table: creditCardTable,
        where: '$creditCardIdColumn = ?',
        whereargs: [creditCardId]);
    if (result.isNotEmpty) {
      return CreditCardModel.fromMapDB(result.first);
    }
    return null;
  }

  Future<int> saveCreditCardDB(CreditCardModel creditCard) async {
    final result = await insertData(creditCardTable, creditCard.toMapDB());
    return result;
  }

  Future<int> updateCreditCardDb(CreditCardModel creditCard) async {
    final result = await updateData(creditCardTable, creditCard.toMapDB(),
        where: '$creditCardIdColumn = ?', args: [creditCard.idCreditCard!]);
    return result;
  }

  Future<int> deleteCreditCardDb(int creditCardId) async {
    return await deleteData(
      table: creditCardTable,
      where: '$creditCardIdColumn = ?',
      whereargs: [creditCardId],
    );
  }

  // EXPENSES
  Future<int> insertExpenseDb(List<ExpensesModel> values) async {
    Database myDb = await db;
    Batch batch = myDb.batch();

    for (var expenses in values) {
      batch.insert(expensesTable, expenses.toMapDB());
    }

    await batch.commit(noResult: true);
    return 1;
  }

  Future<List<ExpensesModel>> getExpensesListDb() async {
    final result = await readData(table: expensesTable);
    List<ExpensesModel> expensesList = result
        .map<ExpensesModel>((expense) => ExpensesModel.fromMapDB(expense))
        .toList();
    return expensesList;
  }

  Future<ExpensesModel?> getExpenseByIdExpense(int expenseId) async {
    List result = await readData(
        table: expensesTable,
        where: '$expenseIdColumn = ?',
        whereargs: [expenseId]);
    if (result.isNotEmpty) {
      return ExpensesModel.fromMapDB(result.first);
    }
    return null;
  }

  Future<int> saveExpenseDB(ExpensesModel expense) async {
    final result = await insertData(expensesTable, expense.toMapDB());
    return result;
  }

  Future<int> updateExpenseDb(ExpensesModel expense) async {
    final result = await updateData(expensesTable, expense.toMapDB(),
        where: '$expenseIdColumn = ?', args: [expense.idExpense!]);
    return result;
  }

  Future<int> deleteAllExpensesByCreditCardDb(int creditCardId) async {
    List<ExpensesModel> expenseList = await getExpensesListDb();
    expenseList.removeWhere((expenses) => expenses.idExpense != creditCardId);
    var qtde = 0;
    for (ExpensesModel expense in expenseList) {
      await deleteExpensesDb(expense.idExpense!);
      qtde++;
    }
    return qtde;
  }

  Future<int> deleteExpensesDb(int expenseId) async {
    return await deleteData(
      table: expensesTable,
      where: '$expenseIdColumn = ?',
      whereargs: [expenseId],
    );
  }
}
