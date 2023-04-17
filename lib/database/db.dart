import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DB {
  //Construtor com acesso privado
  DB._();

  //Instância de DB
  static final DB instance = DB._();

  //Instância do SQLite
  static Database? _database;

  get database async {
    if (_database != null) return _database;
    return await _initDatabase();
  }

  _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'financialcontrol.db'),
      version: 1,
      onCreate: _onCreate,
    );
  }

  _onCreate(db, version) async {
    await db.execute(_expenses);
    await db.execute(_marketPlan);
    await db.execute(_creditCard);
    await db.execute(_user);
    await db.insert('expenses', {'value': 0.00});
  }

  String get _expenses => ''' 
  CREATE TABLE expense(
    idExpense INTEGER PRIMARY KEY AUTOINCREMENT,
    market TEXT,
    payment INTEGER,
    idCreditCard INTEGER,
    idUser INTEGER,
    idMarketPlan INTEGER,
    idUser INTEGER,
    installments INTEGER,
    purchaseValue REAL,
  );
  ''';

  String get _marketPlan => ''' 
  CREATE TABLE marketPlan(
    idMarketPlan INTEGER PRIMARY KEY AUTOINCREMENT,
    nameUser TEXT,
    dateOfBirth TEXT,
    cpfNumber TEXT,
    phoneNumber TEXT 
  );
  ''';

  String get _user => ''' 
  CREATE TABLE user(
    idUser INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    idUser INTEGER,
    expensesPlan INTEGER
    createdPlan TEXT  
  );
  ''';

  String get _creditCard => ''' 
  CREATE TABLE creditCard(
    idCreditCard INTEGER PRIMARY KEY AUTOINCREMENT,
    nameCreditCard TEXT,
    idUser INTEGER,
    expensesCard INTEGER
    validateDate TEXT ,
    limitValue REAL,
    avaliableLimit REAL

  );
  ''';
}
