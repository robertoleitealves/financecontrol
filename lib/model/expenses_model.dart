import 'package:equatable/equatable.dart';

import '../constants/db_constants.dart';

// ignore: must_be_immutable
class ExpensesModel extends Equatable {
  int? idExpense;
  String? market;
  int? idCreditCard;
  int? idUser;
  int? installments; //QTDE PARCELAS
  double? purchaseValue; //VALOR DA COMPRA
  ExpensesModel({
    this.idExpense,
    this.market,
    this.idCreditCard,
    this.idUser,
    this.installments,
    this.purchaseValue,
  });

  @override
  String toString() {
    return 'ExpensesModel(idExpense: $idExpense, market: $market, idCreditCard: $idCreditCard, idUser: $idUser, installments: $installments, purchaseValue: $purchaseValue)';
  }

  Map<String, dynamic> toMapDB() {
    return <String, dynamic>{
      expenseIdColumn: idExpense,
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
    idCreditCard = map[expenseCreditCardIdColumn];
    idUser = map[expenseUserIdColumn];
    installments = map[expenseInstallmentsColumn];
    purchaseValue = map[expensePurchaseValueColumn];
  }

  @override
  // TODO: implement props
  List<Object?> get props => [idExpense];
}
