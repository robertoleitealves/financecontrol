import 'package:financecontrol/model/credit_card_model.dart';
import 'package:financecontrol/model/marketPlan_model.dart';
import 'package:financecontrol/model/user_model.dart';

class ExpensesDTO {
  int? idExpenseDTO;
  String? marketDTO;
  int? paymentDTO; //0 - CREDIÁRIO | 1 - CARTÃO
  CreditCardModel? idCreditCardDTO;
  UserModel? idUserDTO;
  MarketPlanModel? idMarketPlanDTO; //CREDIÁRIO UTILIZADO
  int? installmentsDTO; //QTDE PARCELAS
  double? purchaseValueDTO; //VALOR DA COMPRA
}
