// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:financecontrol/model/credit_card_model.dart';
import 'package:financecontrol/model/user_model.dart';

import '../constants/db_constants.dart';

// ignore: must_be_immutable
class ExpensesModel {
  late int id;
  late String market;
  late String createdAt;
  late int idCreditCard;
  late CreditCardModel creditCard;
  late int idUser;
  late UserModel user;
  int installments = 1; //QTDE PARCELAS
  double purchaseValue = 0.00; //VALOR DA COMPRA
  ExpensesModel({
    required this.id,
    required this.market,
    required this.createdAt,
    required this.idCreditCard,
    required this.creditCard,
    required this.idUser,
    required this.user,
    required this.installments,
    required this.purchaseValue,
  });

  @override
  String toString() {
    return 'ExpensesModel(idExpense: $id, market: $market, createdAt: $createdAt, idCreditCard: $idCreditCard, creditCard: $creditCard, idUser: $idUser, user: $user, installments: $installments, purchaseValue: $purchaseValue)';
  }

  Map<String, dynamic> toMapDB() {
    return <String, dynamic>{
      expenseIdColumn: id,
      expenseCreatedAtColumn: createdAt,
      expenseMarketColumn: market,
      expenseCreditCardIdColumn: idCreditCard,
      expenseUserIdColumn: idUser,
      expenseInstallmentsColumn: installments,
      expensePurchaseValueColumn: purchaseValue,
    };
  }

  ExpensesModel.fromMapDB(Map<String, dynamic> map) {
    id = map[expenseIdColumn];
    market = map[expenseMarketColumn];
    createdAt = map[expenseCreatedAtColumn];
    idCreditCard = map[expenseCreditCardIdColumn];
    idUser = map[expenseUserIdColumn];
    installments = map[expenseInstallmentsColumn];
    purchaseValue = map[expensePurchaseValueColumn];
  }

  List<Object?> get props => [id];
}
