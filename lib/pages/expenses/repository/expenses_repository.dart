import '../../../database/database_provider.dart';
import '../../../model/credit_card_model.dart';
import '../../../model/user_model.dart';

class CreditCardRepository {
  final _helper = DatabaseProvider();

  Future<UserModel> getUserModelDB() async {
    return await _helper.getUserDb();
  }

  Future<CreditCardModel> getCreditCardByCreditCardId(int cultureId) async {
    List<CreditCardModel> creditCardList = await _helper.getCreditCardsListDb();
    return creditCardList
        .where((creditCard) => creditCard.idCreditCard == cultureId)
        .first;
  }

  Future<List<CreditCardModel>> getCreditCard() async {
    return await _helper.getCreditCardsListDb();
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

  Future<int> deleteProducerDb(int userId) async {
    await _helper.deleteAllCreditCardByUserDb(userId);
    return await _helper.deleteUserDb(userId);
  }
}