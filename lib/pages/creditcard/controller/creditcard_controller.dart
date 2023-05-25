import 'dart:developer';

import 'package:financecontrol/model/credit_card_model.dart';
import 'package:financecontrol/pages/creditcard/repository/creditcard_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../model/expenses_model.dart';
import '../../../../model/user_model.dart';
import '../../../../services/services/validators.dart';
import '../../../../services/utils_services.dart';
import '../../base/controller/data_controller.dart';

class CreditCardController extends GetxController {
  final ScrollController creditController = ScrollController();
  final _dataController = Get.find<DataController>();
  final _repository = CreditCardRepository();
  final RxList<ExpensesModel> _expenseList = <ExpensesModel>[].obs;
  final _utilsServices = UtilsServices();
  UserModel? user;
  final searchFieldController = TextEditingController();
  RxList<CreditCardModel> creditList = <CreditCardModel>[].obs;
  final Rx<CreditCardModel> selectedCreditCard = CreditCardModel().obs;
  final RxBool isLoading = false.obs;
  final double sum = 0.00;
  // ------------- CREATE USER ------------------- //
  final TextEditingController cpfController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController birthdateController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final userFormKey = GlobalKey<FormState>();
  final RxBool _isCpf = true.obs;

  // ------------- CREATE CREDITCARD ----------------------- //

  final TextEditingController _nameCreditCardController =
      TextEditingController();
  final TextEditingController _limitValueController = TextEditingController();
  final TextEditingController _validateDateController = TextEditingController();
  final creditCardFormKey = GlobalKey<FormState>();

  List<CreditCardModel> get creditCardList => creditList;
  CreditCardModel get selectedCard => selectedCreditCard.value;
  @override
  void onInit() {
    super.onInit();
  }

  set setCreditCard(CreditCardModel creditCard) =>
      selectedCreditCard.value = creditCard;

  bool get isCpf => _isCpf.value;

  // CARREGAMENTO DOS DADOS DE FAZENDA/TALHÃO
  Future<void> loadCreditCardListByUser(int userId) async {
    creditList.clear();
    if (_dataController.creditCardList != null) {
      List<CreditCardModel> creditCardAux = _dataController.creditCardList
          .where((creditCard) => creditCard.idUser == userId)
          .toList();
      for (var creditCard in creditCardAux) {
        creditCard.expenses = _dataController.expense
            .where((expense) => expense.idCreditCard == creditCard.idCreditCard)
            .toList();

        creditList.add(creditCard);
      }
    } else {
      creditList = <CreditCardModel>[].obs;
    }
  }

  void onCreditCardSelect(CreditCardModel creditCard) {
    selectedCreditCard.value = creditCard;
    selectedCreditCard.value.expenses ??= <ExpensesModel>[];
    _expenseList.assignAll(selectedCreditCard.value.expenses!);
    update();
  }

  // void changeMask(String? numbers) {
  //   if (numbers != null) {
  //     String newText = numbers.replaceAll(RegExp(r'[^\d]'), "");
  //     if (newText.length == 11) {
  //       newText = newText.substring(0, 3) +
  //           "." +
  //           newText.substring(3, 6) +
  //           "." +
  //           newText.substring(6, 9) +
  //           "-" +
  //           newText.substring(9, 11);
  //     } else if (newText.length == 14) {
  //       newText = newText.substring(0, 2) +
  //           "." +
  //           newText.substring(2, 5) +
  //           "." +
  //           newText.substring(5, 8) +
  //           "/" +
  //           newText.substring(8, 12) +
  //           "-" +
  //           newText.substring(12, 14);
  //     }
  //     _cpfCnpjController.value = _cpfCnpjController.value.copyWith(
  //       text: newText,
  //       selection: TextSelection.collapsed(offset: newText.length),
  //     );
  //   }
  // }

  String? validatorCPF(String? value) {
    if (value != null) {
      _isCpf.value = true;
      return Validators.cpfValidator(value);
    }
    return 'CPF obrigatório';
  }

  void saveUser({CreditCardModel? creditModel}) async {
    if (userFormKey.currentState!.validate()) {
      if (creditModel != null) {
        creditModel.idUser = user?.idUser;
        creditModel.nameCreditCard = _nameCreditCardController.text.trim();
        creditModel.limitValueCard = double.parse(_limitValueController.text);
        creditModel.validateDate = _validateDateController.text;
        creditModel.user = await _repository.getUserModelDB();

        await _repository.updateCreditCardDb(creditModel);
        await _dataController.loadData();
        creditList.assignAll(_dataController.creditCardList);
        Get.back();
        clearCreditCardControllers();
      } else {
        CreditCardModel creditCard = CreditCardModel();

        creditCard.validateDate = _validateDateController.text;
        creditCard.nameCreditCard = _nameCreditCardController.text;
        creditCard.limitValueCard = double.parse(_limitValueController.text);

        creditCard.idCreditCard =
            await _repository.saveNewCreditCardDB(creditCard);
        _dataController.creditCardList.add(creditCard);
        creditList.assignAll(_dataController.creditCardList);
        Get.back();
        clearCreditCardControllers();
        // openCreditCardDetails(_creditCardList.last);
      }
    } else {
      _utilsServices.showToast(
        message: "Todos os dados devem ser preenchidos",
        isError: true,
      );
    }
  }

  Future<void> deleteCreditCardDb(int creditCardId) async {
    try {
      await _repository.deleteCreditCardDb(creditCardId);
      creditList.removeWhere((credit) => credit.idCreditCard == creditCardId);
      _utilsServices.showToast(message: 'Cartão excluído com sucesso!');
      Get.back();
      Get.back();
    } on Exception catch (e, s) {
      log('Erro ao deletar',
          name: 'deleteCreditCardDb', error: e, stackTrace: s);
    }
  }

  void clearCreditCardControllers() {
    _nameCreditCardController.clear();
    _limitValueController.clear();
    _validateDateController.clear();
  }
}
