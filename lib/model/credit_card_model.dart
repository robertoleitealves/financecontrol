// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:json_annotation/json_annotation.dart';

import 'package:financecontrol/model/user_model.dart';

import '../constants/db_constants.dart';
import 'expenses_model.dart';

// part 'credit_card_model.g.dart';

@JsonSerializable()
class CreditCardModel {
  int? id;
  int? idUser;
  int? quantityExpenses = 0;
  UserModel? user;
  String? name;
  String? validateDate;
  double? limitValue = 0.00; //LIMITE TOTAL
  double? avaliableLimit = 0.00; //LIMITE DISPONÍVEL
  List<ExpensesModel>? expenses;
  CreditCardModel({
    this.id,
    this.idUser,
    this.quantityExpenses,
    this.user,
    this.name,
    this.validateDate,
    this.limitValue,
    this.avaliableLimit,
    this.expenses,
  });
 

  @override
  String toString() {
    return 'CreditCardModel(id: $id, idUser: $idUser, quantityExpenses: $quantityExpenses, user: $user, name: $name, validateDate: $validateDate, limitValue: $limitValue, avaliableLimit: $avaliableLimit, expenses: $expenses)';
  }

  Map<String, dynamic> toMapDB() {
    return <String, dynamic>{
      creditCardIdColumn: id,
      creditCardNameColumn: name,
      creditCardUserIdColumn: idUser,
      creditCardQtExpensesColumn: quantityExpenses,
      creditCardValidateDateColumn: validateDate,
      creditCardLimitValueColumn: limitValue,
      creditCardAvaliableLimitColumn: avaliableLimit,
    };
  }

  CreditCardModel.fromMapDB(Map<String, dynamic> map) {
    id = map[creditCardIdColumn];
    name = map[creditCardNameColumn];
    quantityExpenses = map[creditCardQtExpensesColumn];
    idUser = map[creditCardUserIdColumn];
    validateDate = map[creditCardValidateDateColumn];
    limitValue = map[creditCardLimitValueColumn];
    avaliableLimit = map[creditCardAvaliableLimitColumn];
  }
  //   factory CreditCardModel.fromJson(Map<String, dynamic> json) =>
  //     _$CreditCardFromJson(json);

  // Map<String, dynamic> toJson() => _$CreditCardToJson(this);

  List<Object?> get props => [id];

  bool get stringify => true;
}
