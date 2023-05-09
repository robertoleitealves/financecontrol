import '../../../db/database_provider_tg.dart';
import '../../../model/credit_card_model.dart';
import '../../../model/user_model.dart';

class CreditCardRepository {
  final _helper = DatabaseProvider();

  Future<UserModel> getUserModelDB() async {
    return await _helper.getUserDb();
  }

  Future<CreditCardModel> getCreditCardByCreditCardId(int cultureId) async {
    List<CreditCardModel> creditCardList = await _helper.getCreditCardListDb();
    return creditCardList
        .where((creditCard) => creditCard.idCreditCard == cultureId)
        .first;
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

  // PRODUCER
  Future<int> saveNewCreditCardDB(CreditCardModel creditCard) async {
    return await _helper.saveCreditCardDB(creditCard);
  }

  Future<int> updateCreditCardDb(CreditCardModel creditCard) async {
    return await _helper.updateCreditCardDb(creditCard);
  }

  // Future<int> deleteUserDb(int userId) async {
  //   await _helper.deleteAllCreditCardByUserDb(userId);
  //   return await _helper.deleteUserDb(userId);
  // }
}
