import '../database/db_constants.dart';

class CreditCardModel {
  int? idCreditCard;
  int? idUser;
  String? nameCreditCard;
  String? validateDate;
  double? limitValueCard; //LIMITE TOTAL
  double? avaliableLimitCard; //LIMITE DISPONÍVEL
  CreditCardModel({
    this.idCreditCard,
    this.idUser,
    this.nameCreditCard,
    this.validateDate,
    this.limitValueCard,
    this.avaliableLimitCard,
  });

  @override
  String toString() {
    return 'CreditCardModel(idCreditCard: $idCreditCard, idUser: $idUser, nameCreditCard: $nameCreditCard, validateDate: $validateDate, limitValue: $limitValueCard, availableLimit: $avaliableLimitCard)';
  }

  Map<String, dynamic> toMapDB() {
    return <String, dynamic>{
      creditCardIdColumn: idCreditCard,
      creditCardNameColumn: nameCreditCard,
      creditCardUserIdColumn: idUser,
      creditCardValidateDateColumn: validateDate,
      creditCardLimitValueColumn: limitValueCard,
      creditCardAvaliableLimitColumn: avaliableLimitCard,
    };
  }

  CreditCardModel.fromMapDB(Map<String, dynamic> map) {
    idCreditCard = map[creditCardIdColumn];
    nameCreditCard = map[creditCardNameColumn];
    idUser = map[creditCardUserIdColumn];
    validateDate = map[creditCardValidateDateColumn];
    limitValueCard = map[creditCardLimitValueColumn];
    avaliableLimitCard = map[creditCardAvaliableLimitColumn];
  }
}
