// import 'package:financecontrol/data/constants.dart';
// import 'package:financecontrol/model/expenses_model.dart';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';



// class DB {
//   Future<Database> getDatabase() async {
//     //MÉTODO PARA DELETAR BANCO DE DADOS
//     // await deleteDatabase(
//     //   join(
//     //     await getDatabasesPath(),
//     //     DATABASE_NAME,
//     //   ),
//     // );
//     //MÉTODO ABERTURA DE BANCO DE DADOS
//     return openDatabase(
//       join(await getDatabasesPath(), DATABASE_NAME),
//       onCreate: (db, version) async {
//         // await db.execute(CREATE_USER_TABLE_SCRIPT);
//         // await db.rawInsert(
//         //   '''insert into $EXPENSES_TABLE_NAME($EXPENSES_COLUMN_IDUSER, $EXPENSES_COLUMN_PAYMENT,$EXPENSES_COLUMN_IDCREDITCARD,$EXPENSES_COLUMN_MARKETPLAN, $EXPENSES_COLUMN_PURCHASEVALUE, $EXPENSES_COLUMN_INSTALLMENTS,VALUES('01','05', '0', 'null', '03', '120.00', '3' ))''',
//         // );
//         // await db.execute(CREATE_CREDITCARD_TABLE_SCRIPT);
//         // await db.execute(CREATE_MARKETPLAN_TABLE_SCRIPT);
//         // await db.execute(CREATE_EXPENSES_TABLE_SCRIPT);
//       },
//       version: DATABASEVERSION,
//     );
//   }

//   Future<ExpensesModel> createExpense(ExpensesModel expense) async {
//     try {
//       final Database db = await getDatabase();
//       expense.idExpense = await db.rawInsert(
//         '''insert into $EXPENSES_TABLE_NAME($EXPENSES_COLUMN_IDUSER, 
//         $EXPENSES_COLUMN_PAYMENT, $EXPENSES_COLUMN_MARKET,
//         $EXPENSES_COLUMN_IDCREDITCARD,$EXPENSES_COLUMN_MARKETPLAN, 
//         $EXPENSES_COLUMN_PURCHASEVALUE, $EXPENSES_COLUMN_INSTALLMENTS,
//         VALUES(${expense.idUser},${expense.payment},
//         ${expense.market}, ${expense.idCreditCard}, 
//         ${expense.idMarketPlan}, ${expense.purchaseValue}, 
//         ${expense.installments} ))''',
//       );
//     } catch (e) {
//       // return (e);
//     }
//     return expense;
//   }

  
// }

// const int DATABASEVERSION = 1;
