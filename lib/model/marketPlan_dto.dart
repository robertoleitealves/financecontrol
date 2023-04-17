// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:financecontrol/model/expenses_model.dart';
import 'package:financecontrol/model/user_model.dart';

class MarketPlanDTO {
  int? idMarketPlanDTO;
  UserModel? idUserDTO;
  String? nameMarketDTO;
  List<ExpensesModel>? expensesPlanDTO;
  String? createdPlanDTO;
  MarketPlanDTO({
    this.idMarketPlanDTO,
    this.idUserDTO,
    this.nameMarketDTO,
    this.expensesPlanDTO,
    this.createdPlanDTO,
  });

  @override
  String toString() {
    return 'MarketPlanDTO(idMarketPlanDTO: $idMarketPlanDTO, idUserDTO: $idUserDTO, nameMarketDTO: $nameMarketDTO, expensesPlanDTO: $expensesPlanDTO, createdPlanDTO: $createdPlanDTO)';
  }
}
