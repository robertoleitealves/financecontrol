// // import 'package:izconsultores/src/db/db_constants.dart';
// // import 'package:izconsultores/src/models/models.dart';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';

// import '../model/credit_card_model.dart';
// import '../model/expenses_model.dart';
// import '../model/user_model.dart';

// class DatabaseProvider {
//   static final DatabaseProvider _instance = DatabaseProvider._init();
//   factory DatabaseProvider() => _instance;
//   Database? _db;
//   DatabaseProvider._init();

//   // Verifica se há algum Database já criado, se não, ele cria
//   Future<Database> get db async {
//     if (_db != null) {
//       return _db!;
//     } else {
//       _db = await initDb();
//       return _db!;
//     }
//   }

//   // START DATABASE
//   initDb() async {
//     // Get a location using getDatabasesPath
//     String databasePath = await getDatabasesPath();
//     String path = join(databasePath, 'iz_consultores.db');
//     // Abrindo um database
//     Database myDb = await openDatabase(path,
//         version: 1, onCreate: _onCreate, onUpgrade: _onUpgrade);
//     return myDb;
//   }

//   // CLOSE DATABASE
//   Future close() async {
//     final _db = await _instance.db;
//     _db.close();
//   }

//   // METHODS
//   readData({
//     required String table,
//     List<String>? columns,
//     String? where,
//     List? whereargs,
//   }) async {
//     Database? mydb = await db;
//     List<Map> response = await mydb.query(table,
//         columns: columns, where: where, whereArgs: whereargs);
//     return response;
//   }

//   insertData(String table, Map<String, dynamic> values) async {
//     Database? mydb = await db;
//     int response = await mydb.insert(table, values);
//     return response;
//   }

//   updateData(String table, Map<String, dynamic> values,
//       {String? where, List<Object>? args}) async {
//     Database? mydb = await db;
//     int response =
//         await mydb.update(table, values, where: where, whereArgs: args);
//     return response;
//   }

//   deleteData({required String table, String? where, List? whereargs}) async {
//     Database? mydb = await db;
//     int response = await mydb.delete(table, where: where, whereArgs: whereargs);
//     return response;
//   }

//   // WHEN DB UPGRADE
//   _onUpgrade(Database db, int oldVersion, int newVersion) async {
//     // TODO: FAZER UPGRADE DO BANCO DE DADOS
//   }

//   // CREATING TABLES
//   _onCreate(Database db, int version) async {
//     //const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL';

//    await db.execute(CREATE_USER_TABLE_SCRIPT);
//         await db.rawInsert(
//           '''insert into $EXPENSES_TABLE_NAME($EXPENSES_COLUMN_IDUSER, $EXPENSES_COLUMN_PAYMENT,$EXPENSES_COLUMN_IDCREDITCARD,$EXPENSES_COLUMN_MARKETPLAN, $EXPENSES_COLUMN_PURCHASEVALUE, $EXPENSES_COLUMN_INSTALLMENTS,VALUES('01','05', '0', 'null', '03', '120.00', '3' ))''',
//         );
//         await db.execute(CREATE_CREDITCARD_TABLE_SCRIPT);
//         await db.execute(CREATE_EXPENSES_TABLE_SCRIPT);
//         const String DATABASE_NAME = 'db_financial_control';

// const String EXPENSES_TABLE_NAME = 'expenses';
// const String EXPENSES_COLUMN_IDEXPENSE = 'idmarketplan';
// const String EXPENSES_COLUMN_IDUSER = 'iduser';
// const String EXPENSES_COLUMN_MARKET = 'market';
// const String EXPENSES_COLUMN_PAYMENT = 'payment';
// const String EXPENSES_COLUMN_IDCREDITCARD = 'idcreditcard';
// const String EXPENSES_COLUMN_MARKETPLAN = 'marketplan';
// const String EXPENSES_COLUMN_PURCHASEVALUE = 'puschasevalue';
// const String EXPENSES_COLUMN_INSTALLMENTS = 'installments';

// const String CREATE_EXPENSES_TABLE_SCRIPT =
//     ''' CREATE TABLE $EXPENSES_TABLE_NAME (
//   $EXPENSES_COLUMN_IDEXPENSE INTEGER PRIMARY KEY AUTOINCREMENT,
//   $EXPENSES_COLUMN_IDUSER INTEGER,
//   $EXPENSES_COLUMN_MARKET TEXT,
//   $EXPENSES_COLUMN_PAYMENT INTEGER,
//   $EXPENSES_COLUMN_IDCREDITCARD INTEGER,
//   $EXPENSES_COLUMN_MARKETPLAN INTEGER,
//   $EXPENSES_COLUMN_PURCHASEVALUE REAL,
//   $EXPENSES_COLUMN_INSTALLMENTS INTEGER
// ) ''';



// const String CREDITCARD_TABLE_NAME = 'creditcard';
// const String CREDITCARD_COLUMN_IDCREDITCARD = 'idcredicard';
// const String CREDITCARD_COLUMN_IDUSER = 'iduser';
// const String CREDITCARD_COLUMN_NAMECREDITCARD = 'namecreditcard';
// const String CREDITCARD_COLUMN_VALIDATEDATE = 'validatedate';
// const String CREDITCARD_COLUMN_EXPENSESCARD = 'expensescard';
// const String CREDITCARD_COLUMN_LIMITVALUECARD = 'limitvaluecard';
// const String CREDITCARD_COLUMN_AVALIABLEVALUECARD = 'avaliablevaluecard';

// const String CREATE_CREDITCARD_TABLE_SCRIPT =
//     ''' CREATE TABLE $CREDITCARD_TABLE_NAME (
//   $CREDITCARD_COLUMN_IDCREDITCARD INTEGER PRIMARY KEY AUTOINCREMENT,
//   $CREDITCARD_COLUMN_IDUSER INTEGER,
//   $CREDITCARD_COLUMN_NAMECREDITCARD TEXT,
//   $CREDITCARD_COLUMN_VALIDATEDATE TEXT,
//   $CREDITCARD_COLUMN_EXPENSESCARD TEXT,
//   $CREDITCARD_COLUMN_LIMITVALUECARD REAL,
//   $CREDITCARD_COLUMN_AVALIABLEVALUECARD REAL,
 
// ) ''';

// const String USER_TABLE_NAME = 'users';
// const String USER_COLUMN_USERNAME = 'username';
// const String USER_COLUMN_IDUSER = 'iduser';
// const String USER_COLUMN_DATEOFBIRTH = 'dateofbirth';
// const String USER_COLUMN_CPFNUMBER = 'cpfnumber';
// const String USER_COLUMN_PHONENUMBER = 'phonenumber';
// const String USER_COLUMN_PASSWORDUSER = 'passworduser';

// const String CREATE_USER_TABLE_SCRIPT =
//     ''' CREATE TABLE $CREDITCARD_TABLE_NAME (
//   $USER_COLUMN_IDUSER INTEGER PRIMARY KEY AUTOINCREMENT,
//   $USER_COLUMN_USERNAME TEXT,
//   $USER_COLUMN_DATEOFBIRTH TEXT,
//   $USER_COLUMN_CPFNUMBER TEXT,
//   $USER_COLUMN_PHONENUMBER TEXT,
//   $USER_COLUMN_PASSWORDUSER TEXT,
 
// ) ''';

//   }
  


//   // ---------------------- //

//   // DELETE TABLES WHEN SIGN OUT
//   Future<void> deleteDbTablesSignOut() async {
//     await deleteData(table: producerTable);
//     await deleteData(table: farmTable);
//     await deleteData(table: fieldTable);
//     await deleteData(table: fieldMapTable);
//   }

//   // USER
//   Future<int> saveUserDb(UserModel user) async {
//     await deleteData(table: userTable);
//     var id = await insertData(userTable, user.toMapDB());
//     return id;
//   }

//   Future<UserModel> getUserDb({bool getAllFields = false}) async {
//     final result = await readData(table: userTable);
//     UserModel response = UserModel.fromMapDB(result.first);
//     if (getAllFields) {
//       response.customUserAddress = await getCustomUserAddressDb();
//       response.customLevelUser = await getCustomLevelUserDb();
//       response.customLevelUser?.level = await getUserLevelDb();
//     }
//     return response;
//   }

//   Future<int> updateUserDb(UserModel user) async {
//     int result = await updateData(
//       userTable,
//       user.toMapDB(),
//     );
//     return result;
//   }

//   // // AUTH
//   // Future<int> saveTokenDb(TokenModel tokenModel) async {
//   //   await deleteData(table: authUserTable);
//   //   return await insertData(authUserTable, tokenModel.toMapDb());
//   // }

//   // Future<TokenModel> getTokenDb() async {
//   //   List result = await readData(table: authUserTable);
//   //   return TokenModel.fromMapDb(result.first);
//   // }

//   // CUSTOM USER ADDRESS
//   // Future<int> saveUserAddressDb(CustomUserAddressModel address) async {
//   //   await deleteData(table: userAddressTable);
//   //   var id = await insertData(userAddressTable, address.toMapDb());
//   //   return id;
//   // }

//   // Future<CustomUserAddressModel> getCustomUserAddressDb() async {
//   //   final result = await readData(table: userAddressTable);
//   //   final response = CustomUserAddressModel.fromMapDb(result.first);
//   //   return response;
//   // }

//   // // CUSTOM LEVEL USER
//   // Future<int> saveCustomLevelUserDb(CustomLevelUserModel levelUser) async {
//   //   await deleteData(table: customLevelUserTable);
//   //   return await insertData(customLevelUserTable, levelUser.toMapDb());
//   // }

//   // Future<CustomLevelUserModel> getCustomLevelUserDb() async {
//   //   final result = await readData(table: customLevelUserTable);
//   //   CustomLevelUserModel response =
//   //       CustomLevelUserModel.fromMapDb(result.first);
//   //   return response;
//   // }

//   // // USER LEVEL
//   // Future<int> saveUserLevelDb(UserLevelModel userLevel) async {
//   //   await deleteData(table: userLevelTable);
//   //   final respose = await insertData(userLevelTable, userLevel.toMapDb());
//   //   return respose;
//   // }

//   // Future<UserLevelModel> getUserLevelDb() async {
//   //   final result = await readData(table: userLevelTable);
//   //   UserLevelModel response = UserLevelModel.fromMapDb(result.first);
//   //   return response;
//   // }

//   // // NATURAL ENEMY
//   // Future<int> insertNaturalEnemiesDb(List<NaturalEnemyModel> values) async {
//   //   await deleteData(table: naturalEnemiesTable);

//   //   Database myDb = await db;
//   //   Batch batch = myDb.batch();

//   //   for (var enemy in values) {
//   //     batch.insert(naturalEnemiesTable, enemy.toMapDb());
//   //   }

//   //   await batch.commit(noResult: true);
//   //   return 1;
//   // }

//   // Future<List<NaturalEnemyModel>> getNaturalEnemiesListDb() async {
//   //   List<NaturalEnemyModel> enemiesList = [];
//   //   final result = await readData(table: naturalEnemiesTable);
//   //   enemiesList = result
//   //       .map<NaturalEnemyModel>((enemy) => NaturalEnemyModel.fromMapDb(enemy))
//   //       .toList();
//   //   return enemiesList;
//   // }

//   // // PRODUCT
//   // Future<int> insertProductsDb(List<ProductModel> values) async {
//   //   await deleteData(table: productTable);

//   //   Database myDb = await db;
//   //   Batch batch = myDb.batch();

//   //   for (var product in values) {
//   //     batch.insert(productTable, product.toMapDb());
//   //   }

//   //   await batch.commit(noResult: true);
//   //   return 1;
//   // }

//   // Future<List<ProductModel>> getProductListDb() async {
//   //   final result = await readData(table: productTable);
//   //   List<ProductModel> productList = result
//   //       .map<ProductModel>((product) => ProductModel.fromMapDb(product))
//   //       .toList();
//   //   return productList;
//   // }

//   // // CONTAMINATION
//   // Future<int> insertContaminationsDb(List<ContaminationModel> values) async {
//   //   await deleteData(table: contaminationTable);

//   //   Database myDb = await db;
//   //   Batch batch = myDb.batch();

//   //   for (var contamination in values) {
//   //     batch.insert(contaminationTable, contamination.toMapDb());
//   //   }

//   //   await batch.commit(noResult: true);
//   //   return 1;
//   // }

//   // Future<List<ContaminationModel>> getContaminationListDb() async {
//   //   final result = await readData(table: contaminationTable);
//   //   List<ContaminationModel> contaminationList = result
//   //       .map<ContaminationModel>(
//   //           (contamination) => ContaminationModel.fromMapDb(contamination))
//   //       .toList();
//   //   return contaminationList;
//   // }

//   // // CULTURE
//   // Future<int> insertCultureDb(List<CultureModel> values) async {
//   //   await deleteData(table: cultureTable);

//   //   Database myDb = await db;
//   //   Batch batch = myDb.batch();

//   //   for (var culture in values) {
//   //     batch.insert(cultureTable, culture.toMapDb());
//   //   }

//   //   await batch.commit(noResult: true);
//   //   return 1;
//   // }

//   // Future<List<CultureModel>> getCultureListDb() async {
//   //   final result = await readData(table: cultureTable);
//   //   List<CultureModel> cultureList = result
//   //       .map<CultureModel>((culture) => CultureModel.fromMapDb(culture))
//   //       .toList();
//   //   return cultureList;
//   // }

//   // PRODUCERS
//   Future<int> insertExpensesDb(List<ExpensesModel> values) async {
//     Database myDb = await db;
//     Batch batch = myDb.batch();

//     for (var expenses in values) {
//       batch.insert(expenseTable, expenses.toMapDb());
//     }

//     await batch.commit(noResult: true);
//     return 1;
//   }

//   Future<List<ExpensesModel>> getProducersListDb() async {
//     final result = await readData(table: expenseTable);
//     List<ExpensesModel> expensesList = result
//         .map<ExpensesModel>((producers) => ExpensesModel.fromMapDb(producers))
//         .toList();
//     return expensesList;
//   }

//   Future<ExpensesModel?> getProducerByIdDb(int producerId) async {
//     List result = await readData(
//         table: expenseTable,
//         where: '$expenseIdColumn = ?',
//         whereargs: [expenseId]);
//     if (result.isNotEmpty) {
//       return ExpensesModel.fromMapDb(result.first);
//     }
//     return null;
//   }

//   Future<int> saveExpenseDB(ExpensesModel expense) async {
//     final result = await insertData(expenseTable, expense.toMapDb());
//     return result;
//   }

//   Future<int> updateExpenseDb(ExpensesModel expense) async {
//     final result = await updateData(expenseTable, expense.toMapDb(),
//         where: '$expenseIdColumn = ?', args: [expense.idExpense!]);
//     return result;
//   }

//   Future<int> deleteExpenseDb(int expenseId) async {
//     return await deleteData(
//       table: expenseTable,
//       where: '$expenseIdColumn = ?',
//       whereargs: [expenseId],
//     );
//   }

//   // FARMS
//   Future<int> insertFarmsDb(List<CreditCardModel> values) async {
//     Database myDb = await db;
//     Batch batch = myDb.batch();

//     for (var creditCard in values) {
//       batch.insert(creditCardTable, creditCard.toMapDb());
//     }

//     await batch.commit(noResult: true);
//     return 1;
//   }

//   Future<List<CreditCardModel>> getFarmsListDb() async {
//     final result = await readData(table: creditCardTable);
//     List<CreditCardModel> creditCardList =
//         result.map<CreditCardModel>((credits) => CreditCardModel.fromMapDb(credits)).toList();
//     return creditCardList;
//   }

 

//   Future<int> saveFarmDB(CreditCardModel creditCard) async {
//     final result = await insertData(creditCardTable, creditCard.toMapDb());
//     return result;
//   }

//   Future<int> updateFarmDb(CreditCardModel creditCard) async {
//     final result = await updateData(creditCardTable, creditCard.toMapDb(),
//         where: '$creditCardIdColumn = ?', args: [creditCard.idCreditCard!]);
//     return result;
//   }

//   // Future<int> deleteAllFarmsByProducerDb(int producerId) async {
//   //   List<FarmModel> farmList = await getFarmsListDb();
//   //   farmList.removeWhere((farm) => farm.producerId != producerId);
//   //   var qtde = 0;
//   //   for (FarmModel farm in farmList) {
//   //     await deleteFarmDb(farm.id!);
//   //     qtde++;
//   //   }
//   //   return qtde;
//   // }

//   Future<int> deleteCreditCardDb(int creditCardId) async {
//     return await deleteData(
//       table: creditCardTable,
//       where: '$creditCardIdColumn = ?',
//       whereargs: [creditCardId],
//     );
//   }

//   // FIELDS
 
// }
