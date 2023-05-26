import 'dart:developer';

import 'package:get/get.dart';

import '../../../db/database_provider_tg.dart';
import '../../../model/credit_card_model.dart';
import '../../../model/user_model.dart';
import '../../auth/controller/auth_controller.dart';

class CreditCardRepository {
  final _helper = DatabaseProvider();
  final _authController = Get.find<AuthController>();

  Future<UserModel> getUserModelDB() async {
    return await _helper.getUserDb();
  }

  Future<List<CreditCardModel>> getCreditCardByUserIdDb(int userId) async {
    try {
      final result =
          await _helper.getCreditCardByIdUserDb(_authController.user.idUser!);
      if (result.isNotEmpty) {
        return result;
      } else {
        return <CreditCardModel>[];
      }
    } catch (e, s) {
      log("Erro", error: e, stackTrace: s);
      return [];
    }
  }

  Future<List<CreditCardModel>> getCreditCard() async {
    return await _helper.getCreditCardListDb();
  }

  Future saveCreditCardByUser({
    required int userId,
    required CreditCardModel creditCard,
  }) async {
    creditCard.idUser = userId;
    await _helper.saveCreditCardDB(creditCard);
  }

  // CREDITCARD
  Future<int> saveNewCreditCardDB(CreditCardModel creditCard) async {
    return await _helper.saveCreditCardDB(creditCard);
  }

  Future<int> updateCreditCardDb(CreditCardModel creditCard) async {
    return await _helper.updateCreditCardDb(creditCard);
  }

  Future<int> deleteCreditCardDb(int creditId) async {
    await _helper.deleteAllExpensesByCreditCardDb(creditId);
    return await _helper.deleteCreditCardDb(creditId);
  }
}
