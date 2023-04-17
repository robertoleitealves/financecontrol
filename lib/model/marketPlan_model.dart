class MarketPlanModel {
  int? idMarketPlan;
  int? idUser;
  String? nameMarket;
  List? expensesPlan;
  String? createdPlan;
  double? limitValue; //LIMITE TOTAL
  double? availableLimit; //LIMITE DISPONÍVEL
  MarketPlanModel({
    this.idMarketPlan,
    this.idUser,
    this.nameMarket,
    this.expensesPlan,
    this.createdPlan,
    this.limitValue,
    this.availableLimit,
  });

  @override
  String toString() {
    return 'MarketPlanModel(idMarketPlan: $idMarketPlan, idUser: $idUser, nameMarket: $nameMarket, expensesPlan: $expensesPlan, createdPlan: $createdPlan, limitValue: $limitValue, availableLimit: $availableLimit)';
  }
}
