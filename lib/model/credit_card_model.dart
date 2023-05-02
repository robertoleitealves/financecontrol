class CreditCardModel {
  int? idCreditCard;
  int? idUser;
  String? nameCreditCard;
  String? validateDate;
  double? limitValuecard; //LIMITE TOTAL
  double? availableLimitcard; //LIMITE DISPONÍVEL
  CreditCardModel({
    this.idCreditCard,
    this.idUser,
    this.nameCreditCard,
    this.validateDate,
    this.limitValuecard,
    this.availableLimitcard,
  });

  @override
  String toString() {
    return 'CreditCardModel(idCreditCard: $idCreditCard, idUser: $idUser, nameCreditCard: $nameCreditCard, validateDate: $validateDate, limitValue: $limitValuecard, availableLimit: $availableLimitcard)';
  }
}
