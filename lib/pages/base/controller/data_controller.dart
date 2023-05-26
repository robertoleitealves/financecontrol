import 'package:get/get.dart';

import '../../../model/credit_card_model.dart';
import '../../../model/expenses_model.dart';
import '../../../model/user_model.dart';
import '../repository/data_repository.dart';

class DataController extends GetxController {
  final DataRepository _repository = DataRepository();

  final UserModel _user = UserModel();
  String? _token;
  final bool _isLoading = true;

  
  UserModel get user => _user;

  String get token => _token!;
  bool get isLoading => _isLoading;


}
