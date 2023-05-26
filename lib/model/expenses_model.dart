// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:financecontrol/model/credit_card_model.dart';
import 'package:financecontrol/model/user_model.dart';

import '../constants/db_constants.dart';

// ignore: must_be_immutable
class ExpensesModel {
  int? idExpense;
  String? market;
  String? createdAt;
  int? idCreditCard;
  CreditCardModel? creditCard;
  int? idUser;
  UserModel? user;
  int? installments; //QTDE PARCELAS
  double? purchaseValue; //VALOR DA COMPRA
  ExpensesModel({
    this.idExpense,
    this.market,
    this.createdAt,
    this.idCreditCard,
    this.creditCard,
    this.idUser,
    this.user,
    this.installments,
    this.purchaseValue,
  });

  @override
  String toString() {
    return 'ExpensesModel(idExpense: $idExpense, market: $market, createdAt: $createdAt, idCreditCard: $idCreditCard, creditCard: $creditCard, idUser: $idUser, user: $user, installments: $installments, purchaseValue: $purchaseValue)';
  }

  Map<String, dynamic> toMapDB() {
    return <String, dynamic>{
      expenseIdColumn: idExpense,
      expenseCreatedAtColumn: createdAt,
      expenseMarketColumn: market,
      expenseCreditCardIdColumn: idCreditCard,
      expenseUserIdColumn: idUser,
      expenseInstallmentsColumn: installments,
      expensePurchaseValueColumn: purchaseValue,
    };
  }

  ExpensesModel.fromMapDB(Map<String, dynamic> map) {
    idExpense = map[expenseIdColumn];
    market = map[expenseMarketColumn];
    createdAt = map[expenseCreatedAtColumn];
    idCreditCard = map[expenseCreditCardIdColumn];
    idUser = map[expenseUserIdColumn];
    installments = map[expenseInstallmentsColumn];
    purchaseValue = map[expensePurchaseValueColumn];
  }


  List<Object?> get props => [idExpense];
}
