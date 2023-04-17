class MarketPlanModel {
  int? idMarketPlan;
  int? idUser;
  String? nameMarket;
  List? expensesPlan;
  double? limitValue; //LIMITE TOTAL
  double? availableLimit; //LIMITE DISPONÍVEL
  MarketPlanModel({
    this.idMarketPlan,
    this.idUser,
    this.nameMarket,
    this.expensesPlan,
    this.limitValue,
    this.availableLimit,
  });

  @override
  String toString() {
    return 'MarketPlanModel(idMarketPlan: $idMarketPlan, idUser: $idUser, nameMarket: $nameMarket, expensesPlan: $expensesPlan, limitValue: $limitValue, availableLimit: $availableLimit)';
  }
}
