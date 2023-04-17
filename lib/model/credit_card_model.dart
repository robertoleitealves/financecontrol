

class CreditCardModel {
  int? idCreditCard;
  int? idUser;
  String? nameCreditCard;
  String? validateDate;
  List? expensesCard;
  double? limitValue; //LIMITE TOTAL
  double? availableLimit; //LIMITE DISPONÍVEL
  CreditCardModel({
    this.idCreditCard,
    this.idUser,
    this.nameCreditCard,
    this.validateDate,
    this.expensesCard,
    this.limitValue,
    this.availableLimit,
  });

  

  @override
  String toString() {
    return 'CreditCardModel(idCreditCard: $idCreditCard, idUser: $idUser, nameCreditCard: $nameCreditCard, validateDate: $validateDate, expensesCard: $expensesCard, limitValue: $limitValue, availableLimit: $availableLimit)';
  }
}
