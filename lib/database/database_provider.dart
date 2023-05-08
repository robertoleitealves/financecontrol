import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/credit_card_model.dart';
import '../model/expenses_model.dart';
import '../model/user_model.dart';
import 'db_constants.dart';

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
    String path = join(databasePath, 'financial_controls.db');
    // Abrindo um database
    Database myDb = await openDatabase(path,
        version: 1, onCreate: _onCreate, onUpgrade: _onUpgrade);
    return myDb;
  }

  //CREATE EXPENSES
  Future<ExpensesModel> createExpenses(ExpensesModel expense) async {
    try {
      final Database db = initDb();

      expense.idExpense = await db
          .rawInsert('''insert into $expensesTable($expenseUserIdColumn, 
         $expenseMarketColumn,
        $expenseCreditCardIdColumn,
        $expensePurchaseValueColumn, $expenseInstallmentsColumn,
        VALUES(${expense.idUser},
        ${expense.market}, ${expense.idCreditCard}, 
         ${expense.purchaseValue}, 
        ${expense.installments} ))''');
    } catch (ex) {
      return expense;
    }
    return expense;
  }

  //CREATE CREDITCARD
  Future<CreditCardModel> createCreditCard(CreditCardModel creditCard) async {
    try {
      final Database db = initDb();

      creditCard.idCreditCard = await db
          .rawInsert('''insert into $expensesTable($creditCardUserIdColumn, 
         $creditCardNameColumn,$creditCardValidateDateColumn,
        $creditCardLimitValueColumn, $creditCardAvaliableLimitColumn,
        VALUES(${creditCard.idUser},
        ${creditCard.nameCreditCard}, ${creditCard.validateDate}, 
         ${creditCard.avaliableLimitCard}, 
        ${creditCard.limitValueCard} ))''');
    } catch (ex) {
      return creditCard;
    }
    return creditCard;
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
            $userPasswordColumn INTEGER,
 
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
              $expensePurchaseValueColumn REAL,
        
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
              $creditCardLimitValueColumn TEXT,
             
            )
            ''');
  }

  // ---------------------- //

  // // DELETE TABLES WHEN SIGN OUT
  // Future<void> deleteDbTablesSignOut() async {
  //   await deleteData(table: userTable);
  //   await deleteData(table: expenseTable);
  //   await deleteData(table: creditCardTable);
  // }

  // USER
  Future<int> saveUserDb(UserModel user) async {
    await deleteData(table: userTable);
    var id = await insertData(
      userTable,
      user.toJson(),
    );
    return id;
  }

  Future<UserModel> getUserDb() async {
    final result = await readData(table: userTable);
    UserModel response = UserModel.fromJson(result.first);
    // if (getAllFields) {
    //   response.customUserAddress = await getCustomUserAddressDb();
    //   response.customLevelUser = await getCustomLevelUserDb();
    //   response.customLevelUser?.level = await getUserLevelDb();
    // }
    return response;
  }

  Future<int> updateUserDb(UserModel user) async {
    int result = await updateData(
      userTable,
      user.toJson(),
    );
    return result;
  }

  // EXPENSES
  Future<int> insertExpensesDb(List<ExpensesModel> values) async {
    await deleteData(table: expensesTable);

    Database myDb = await db;
    Batch batch = myDb.batch();

    // for (var culture in values) {
    //   batch.insert(cultureTable, culture.toMapDb());
    // }

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

  // USERS
  Future<int> insertUserDB(List<UserModel> values) async {
    Database myDb = await db;
    Batch batch = myDb.batch();

    for (var users in values) {
      batch.insert(userTable, users.toJson());
    }

    await batch.commit(noResult: true);
    return 1;
  }

  Future<int> saveUserDB(UserModel user) async {
    final result = await insertData(userTable, user.toJson());
    return result;
  }

  Future<int> updateUserDB(UserModel user) async {
    final result = await updateData(userTable, user.toJson(),
        where: '$userNameColumn = ?', args: [user.name!]);
    return result;
  }

  Future<int> deleteUserDb(int userId) async {
    return await deleteData(
      table: userTable,
      where: '$userIdColumn = ?',
      whereargs: [userId],
    );
  }

  // EXPENSES
  Future<int> insertExpensesDB(List<ExpensesModel> values) async {
    Database myDb = await db;
    Batch batch = myDb.batch();

    for (var expenses in values) {
      batch.insert(expensesTable, expenses.toMapDB());
    }

    await batch.commit(noResult: true);
    return 1;
  }

  Future<int> saveExpensesDB(ExpensesModel expenses) async {
    final result = await insertData(expensesTable, expenses.toMapDB());
    return result;
  }

  Future<ExpensesModel> getExpensesByIdExpenses(int expensesId) async {
    final result = await readData(
        table: expensesTable,
        where: "$expenseIdColumn = ?",
        whereargs: [expensesId]);
    List<ExpensesModel> expensesList = result
        .map<ExpensesModel>((expense) => ExpensesModel.fromMapDB(expense))
        .toList();
    return expensesList.first;
  }

  Future<int> updateExpensesDb(ExpensesModel expense) async {
    final result = await updateData(expensesTable, expense.toMapDB(),
        where: '$expenseIdColumn = ?', args: [expense.idExpense!]);
    return result;
  }

  Future<int> deleteExpenseDb(int expenseId) async {
    return await deleteData(
      table: expensesTable,
      where: '$expenseIdColumn = ?',
      whereargs: [expenseId],
    );
  }

  // CREDITCARDS
  Future<int> insertCreditCardDb(List<CreditCardModel> values) async {
    Database myDb = await db;
    Batch batch = myDb.batch();

    for (var creditCard in values) {
      batch.insert(creditCardTable, creditCard.toMapDB());
    }

    await batch.commit(noResult: true);
    return 1;
  }

  Future<List<CreditCardModel>> getCreditCardsListDb() async {
    final result = await readData(table: creditCardTable);
    List<CreditCardModel> creditCardList = result
        .map<CreditCardModel>(
            (creditCard) => CreditCardModel.fromMapDB(creditCard))
        .toList();
    return creditCardList;
  }

  Future<CreditCardModel> getCreditCardByIdCreditCard(int creditCardId) async {
    final result = await readData(
        table: creditCardTable,
        where: "$creditCardIdColumn = ?",
        whereargs: [creditCardId]);
    List<CreditCardModel> fieldList = result
        .map<CreditCardModel>(
            (creditCards) => CreditCardModel.fromMapDB(creditCards))
        .toList();
    return fieldList.first;
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
}
