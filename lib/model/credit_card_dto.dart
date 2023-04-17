// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:financecontrol/model/user_model.dart';

import 'expenses_model.dart';

class CreditCardDTO {
   int? idCreditCardDTO;
  UserModel? idUserDTO;
  String? nameCreditCardDTO;
  String? validateDateDTO;
  List<ExpensesModel>? expensesCardDTO;
  double? limitValueDTO; //LIMITE TOTAL
  double? availableLimitDTO; //LIMITE DISPONÍVEL
  CreditCardDTO({
    this.idCreditCardDTO,
    this.idUserDTO,
    this.nameCreditCardDTO,
    this.validateDateDTO,
    this.expensesCardDTO,
    this.limitValueDTO,
    this.availableLimitDTO,
  });

  @override
  String toString() {
    return 'CreditCardDTO(idCreditCardDTO: $idCreditCardDTO, idUserDTO: $idUserDTO, nameCreditCardDTO: $nameCreditCardDTO, validateDateDTO: $validateDateDTO, expensesCardDTO: $expensesCardDTO, limitValueDTO: $limitValueDTO, availableLimitDTO: $availableLimitDTO)';
  }
}
