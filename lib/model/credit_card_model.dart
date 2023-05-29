// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:json_annotation/json_annotation.dart';

import 'package:financecontrol/model/user_model.dart';

import '../constants/db_constants.dart';
import 'expenses_model.dart';

// part 'credit_card_model.g.dart';

@JsonSerializable()
class CreditCardModel {
  int? idCreditCard;
  int? idUser;
  int? qtExpenses = 0;
  UserModel? user;
  String? nameCreditCard;
  String? validateDate;
  double? limitValueCard; //LIMITE TOTAL
  double? avaliableLimitCard; //LIMITE DISPONÍVEL
  List<ExpensesModel>? expenses;
  CreditCardModel({
    this.idCreditCard,
    this.idUser,
    this.qtExpenses,
    this.user,
    this.nameCreditCard,
    this.validateDate,
    this.limitValueCard,
    this.avaliableLimitCard,
    this.expenses,
  });

  @override
  String toString() {
    return 'CreditCardModel(idCreditCard: $idCreditCard, idUser: $idUser, qtExpenses: $qtExpenses, user: $user, nameCreditCard: $nameCreditCard, validateDate: $validateDate, limitValueCard: $limitValueCard, avaliableLimitCard: $avaliableLimitCard, expenses: $expenses)';
  }

  Map<String, dynamic> toMapDB() {
    return <String, dynamic>{
      creditCardIdColumn: idCreditCard,
      creditCardNameColumn: nameCreditCard,
      creditCardUserIdColumn: idUser,
      creditCardQtExpensesColumn: qtExpenses,
      creditCardValidateDateColumn: validateDate,
      creditCardLimitValueColumn: limitValueCard,
      creditCardAvaliableLimitColumn: avaliableLimitCard,
    };
  }

  CreditCardModel.fromMapDB(Map<String, dynamic> map) {
    idCreditCard = map[creditCardIdColumn];
    nameCreditCard = map[creditCardNameColumn];
    qtExpenses = map[creditCardQtExpensesColumn];
    idUser = map[creditCardUserIdColumn];
    validateDate = map[creditCardValidateDateColumn];
    limitValueCard = map[creditCardLimitValueColumn];
    avaliableLimitCard = map[creditCardAvaliableLimitColumn];
  }
  //   factory CreditCardModel.fromJson(Map<String, dynamic> json) =>
  //     _$CreditCardFromJson(json);

  // Map<String, dynamic> toJson() => _$CreditCardToJson(this);

  List<Object?> get props => [idCreditCard];

  bool get stringify => true;
}
