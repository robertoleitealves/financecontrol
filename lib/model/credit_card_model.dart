// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../constants/db_constants.dart';
import 'expenses_model.dart';

// part 'credit_card_model.g.dart';

@JsonSerializable()
class CreditCardModel extends Equatable {
  int? idCreditCard;
  int? idUser;
  String? nameCreditCard;
  String? validateDate;
  double? limitValueCard; //LIMITE TOTAL
  double? avaliableLimitCard; //LIMITE DISPONÍVEL
  List<ExpensesModel>? expenses;
  CreditCardModel({
    this.idCreditCard,
    this.idUser,
    this.nameCreditCard,
    this.validateDate,
    this.limitValueCard,
    this.avaliableLimitCard,
    this.expenses,
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
  //   factory CreditCardModel.fromJson(Map<String, dynamic> json) =>
  //     _$CreditCardFromJson(json);

  // Map<String, dynamic> toJson() => _$CreditCardToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [idCreditCard];

  @override
  bool get stringify => true;
}
