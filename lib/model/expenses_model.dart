// ignore_for_file: public_member_api_docs, sort_constructors_first
class ExpensesModel {
  int? idExpense;
  String? market;
  int? payment; //0 - CREDIÁRIO | 1 - CARTÃO
  int? idCreditCard;
  int? idUser;
  int? idMarketPlan; //CREDIÁRIO UTILIZADO
  int? installments; //QTDE PARCELAS
  double? purchaseValue; //VALOR DA COMPRA
  ExpensesModel({
    this.idExpense,
    this.market,
    this.payment,
    this.idCreditCard,
    this.idUser,
    this.idMarketPlan,
    this.installments,
    this.purchaseValue,
  });

  @override
  String toString() {
    return 'ExpensesModel(idExpense: $idExpense, market: $market, payment: $payment, idCreditCard: $idCreditCard, idUser: $idUser, idMarketPlan: $idMarketPlan, installments: $installments, purchaseValue: $purchaseValue)';
  }
}
