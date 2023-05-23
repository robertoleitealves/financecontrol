import 'package:get/get.dart';

import '../../../model/credit_card_model.dart';
import '../../../model/expenses_model.dart';
import '../../../model/user_model.dart';
import '../repository/data_repository.dart';

class DataController extends GetxController {
  final DataRepository _repository = DataRepository();

  UserModel _user = UserModel();
  String? _token;
  bool _isLoading = true;

  late List<CreditCardModel> _creditCards = [];
  late List<ExpensesModel> _expenses = [];

  UserModel get user => _user;

  List<CreditCardModel> get creditCard => _creditCards;
  List<ExpensesModel> get expense => _expenses;
  String get token => _token!;
  bool get isLoading => _isLoading;

  @override
  onInit() {
    super.onInit();
    loadData();
  }

  Future<void> loadData() async {
    _user = await _repository.getUserModelDB();
    _token = await _repository.getTokenDb();
    _creditCards = await _repository.getCreditCardListDb();
    _expenses = await _repository.getExpensesListDb();
  }
}
