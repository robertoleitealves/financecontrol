import 'dart:developer';

import 'package:financecontrol/model/credit_card_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../model/expenses_model.dart';
import '../../../../model/user_model.dart';
import '../../../../services/services/validators.dart';
import '../../../../services/utils_services.dart';
import '../../../base/controller/data_controller.dart';
import '../../../expenses/repository/expenses_repository.dart';
import '../../../expenses/view/expense_screen.dart';
import '../view/field_screen.dart';

class ProducerController extends GetxController {
  final _dataController = Get.find<DataController>();
  final _repository = CreditCardRepository();

  final _handler = DataHandler();
  final _utilsServices = UtilsServices();

  final RxString searchProducer = ''.obs;
  final searchProducerController = TextEditingController();
  final RxString searchField = ''.obs;
  final searchFieldController = TextEditingController();
  final RxList<CreditCardModel> _creditCardList = <CreditCardModel>[].obs;
  final Rx<ExpensesModel> _selectedExpense = ExpensesModel().obs;
  final Rx<CreditCardModel> _selectedCreditCard = CreditCardModel().obs;
  final RxBool isLoading = false.obs;

  // ------------- CREATE USER ------------------- //
  final TextEditingController cpfController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController birthdateController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  final userFormKey = GlobalKey<FormState>();
  final RxBool _isCpf = true.obs;

  // ------------- CREATE FARM ----------------------- //

  final TextEditingController _farmNameController = TextEditingController();
  final TextEditingController _farmAreaController = TextEditingController();
  final TextEditingController _farmCityController = TextEditingController();
  final TextEditingController _farmStreetController = TextEditingController();
  final TextEditingController _farmNeighborhoodController =
      TextEditingController();

  final RxString _farmState = ''.obs;
  final farmFormKey = GlobalKey<FormState>();


  //--------------------------------------------------//

  @override
  void onInit() {
    super.onInit();

    _creditCardList.addAll(_dataController.creditCard);
    sortFilter(1);



    debounce(
      searchCreditCard,
      (search) {
        if (search != "") {
          filterByCreditCard();
        } else {
          _creditCardList.clear();
          _creditCardList.addAll(_dataController.creditCard);
        }
      },
      time: const Duration(
        milliseconds: 600,
      ),
    );

    debounce(
      searchExpenses,
      (search) {
        if (search != "") {
          filterByExpenses();
        } else {
          _expenseList.clear();
          _expenseList.addAll(_dataController.expense);
        }
      },
      time: const Duration(
        milliseconds: 600,
      ),
    );
  }

  List<CreditCardModel> get creditCardList => _creditCardList;

  ExpensesModel get selectedexpense => _selectedExpense.value;
  CreditCardModel get selectedCreditCard => _selectedCreditCard.value;
 

  set setCreditCard(CreditCardModel creditCard) => _selectedCreditCard.value = creditCard;

  // // PRODUCERS GETTERS
  // TextEditingController get cpfController => _cpfController;
  // TextEditingController get nameController => _nameController;
  // TextEditingController get phoneController => _phoneController;
  

  // bool get isCpf => _isCpf.value;

  // // FARMS GETTERS
  // TextEditingController get farmNameController => _farmNameController;
  // TextEditingController get farmAreaController => _farmAreaController;
  // TextEditingController get farmCityController => _farmCityController;
  // TextEditingController get farmStreetController => _farmStreetController;
  // TextEditingController get farmNeighborhoodController =>
  //     _farmNeighborhoodController;
  // String get farmState => _farmState.value;

  // // FIELDS GETTERS
  // TextEditingController get fieldNameController => _fieldNameController;
  // TextEditingController get fieldAreaController => _fieldAreaController;
  // TextEditingController get fieldPlanningDateController =>


  // FILTROS DOS SEARCHBOX
  void filterByCreditCard() {
    _creditCardList.clear();
    for (var creditCard in _dataController.creditCard) {
      if (creditCard.nameCreditCard!
              .toLowerCase()
              .contains(searchCreditCard.value.toLowerCase()) ||
          ) {
        _creditCardList.add(creditCard);
      }
    }
  }



  void clearSearchBoxField() {
    searchFieldController.clear();
    searchField.value = '';
  }

  void activeFilter(String? name) {
    if (name != null) {
      searchCreditCard.value = name;
    }
  }

  // CARREGAMENTO DOS DADOS DE FAZENDA/TALHÃO
  Future<void> _loadCreditCardListByUser(int userId) async {
    _creditCardList.clear();
    List<CreditCardModel> _creditCardAux = _dataController.creditCard
        .where((creditCard) => creditCard.idUser == userId)
        .toList();
    for (var creditCard in _creditCardAux) {
      creditCard.expenses = _dataController.expense
          .where((expense) => expense.idCreditCard == creditCard.idCreditCard)
          .toList();
      
      _creditCardList.add(creditCard);
    }
  }

 

  // ATUALIZAÇÃO AO SELECIONAR CARD DA FAZENDA
  void onCreditCardSelect(CreditCardModel creditCard) {
    _selectedCreditCard.value = creditCard;
    _selectedCreditCard.value.expenses ??= <ExpensesModel>[];
    _expenseList.assignAll(_selectedCreditCard.value.expenses!);
    update();
  }



 

  
  void onExpenseSelect(ExpensesModel expense) async {
    Get.to(
      () => ExpenseScreen(expense: expense),
      transition: Transition.fadeIn,
    );
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

  void saveUser({UserModel? user}) async {
    if (userFormKey.currentState!.validate()) {
      if (user != null) {
  
        user.cpfNumber = _cpfCnpjController.text.trim();
        user.name = _nameController.text.trim();
        user.lastName = _surnameController.text.trim();
        user.gender = _gender.value == 0 ? "M" : "F";
        user.isCnpj = _isCpf.value ? 0 : 1;
        user.user = await _repository.getUserModelDB();
        user.isUpdated = 1;
        await _repository.updateProducerDb(user);
        await _dataController.loadData();
        _producerList.assignAll(_dataController.producers);
        Get.back();
        clearProducersControllers();
      } else {
        ProducerModel producer = ProducerModel();
        producer.userPlatform = _utilsServices.verifyPlatform();
        producer.cpfCnpj = _cpfCnpjController.text.trim();
        producer.firstName = _nameController.text.trim();
        producer.lastName = _surnameController.text.trim();
        producer.gender = _gender.value == 0 ? "M" : "F";
        producer.isCnpj = _isCpf.value ? 0 : 1;
        producer.user = _dataController.user;
        producer.id = await _repository.saveNewProducerDB(producer);
        _dataController.producers.add(producer);
        _producerList.assignAll(_dataController.producers);
        Get.back();
        clearProducersControllers();
        openProducerDetails(_producerList.last);
      }
    } else {
      _utilsServices.showToast(
        message: "Todos os dados devem ser preenchidos",
        isError: true,
      );
    }
  }

  Future<void> deleteProducerDb(int producerId) async {
    try {
      await _handler.deleteProducer(producerId, _dataController.token);
      await _repository.deleteProducerDb(producerId);
      _producerList.removeWhere((producer) => producer.id == producerId);
      _utilsServices.showToast(message: 'Produtor excluído com sucesso!');
      Get.back();
      Get.back();
    } on Exception catch (e, s) {
      log('Erro ao deletar', name: 'deleteProducerDb', error: e, stackTrace: s);
    }
  }

  void clearProducersControllers() {
    _cpfCnpjController.clear();
    _nameController.clear();
    _surnameController.clear();
    _gender.value = -1;
  }

  // --------------- CREATE FARM -------------------- //

  void changeState(String? state) {
    if (state != null) {
      _farmState.value = state;
    }
  }

  void clearFarmControllers() {
    _farmAreaController.clear();
    _farmCityController.clear();
    _farmNameController.clear();
    _farmStreetController.clear();
    _farmNeighborhoodController.clear();
    _farmState.value = '';
  }

  void saveFarm({FarmModel? farmModel}) async {
    if (farmFormKey.currentState!.validate()) {
      if (farmModel != null) {
        farmModel.name = _farmNameController.text.trim();
        farmModel.hectares = double.parse(_farmAreaController.text.trim());
        farmModel.city = _farmCityController.text.trim();
        farmModel.neighborhood = _farmNeighborhoodController.text.trim();
        farmModel.location = _farmStreetController.text.trim();
        farmModel.state = _farmState.value;
        farmModel.isUpdated = 1;
        await _repository.updateFarmDb(farmModel);
        var index = _farmList.indexWhere((farm) => farm.id == farmModel.id);
        _farmList[index] = farmModel;
        update();
        clearFarmControllers();
        Get.back();
      } else {
        FarmModel farm = FarmModel();
        farm.name = _farmNameController.text.trim();
        farm.hectares = double.parse(_farmAreaController.text.trim());
        farm.city = _farmCityController.text.trim();
        farm.neighborhood = _farmNeighborhoodController.text.trim();
        farm.location = _farmStreetController.text.trim();
        farm.state = _farmState.value;
        farm.producerId = selectedFarm.producerId;
        farm.userId = _dataController.user.id;
        farm.isSync = 0;
        farm.id = await _repository.saveNewFarmDB(farm);
        _dataController.farms.add(farm);
        clearFarmControllers();
        update();
        _selectedFarm.value = _farmList.last;
        Get.back(result: farm);
      }
    }
  }

  Future<void> deleteFarmDb(int farmId) async {
    try {
      await _handler.deleteFarm(farmId, _dataController.token);
      await _repository.deleteFarmDb(farmId);
      _dataController.farms.removeWhere((farm) => farm.id == farmId);
      _farmList.removeWhere((farm) => farm.id == farmId);
      openProducerDetails(_selectedProducer.value);
      if (_farmList.isEmpty) {
        _fieldList.clear();
      }
      _utilsServices.showToast(message: 'Fazenda excluída com sucesso!');
      Get.back();
    } on Exception catch (e, s) {
      log('Erro ao deletar', name: 'deleteFarmDb', error: e, stackTrace: s);
    }
  }

  // --------------- CREATE FIELD -------------------- //

  void clearFieldControllers() {
    _fieldAreaController.clear();
    _fieldNameController.clear();
    _fieldPlanningDateController.clear();
    _cultureSelected = null;
    _soilTypeSelected = null;
  }

  void saveField({FieldModel? fieldModel}) async {
    if (fieldFormKey.currentState!.validate()) {
      var day = _fieldPlanningDateController.text.trim().substring(0, 2);
      var month = _fieldPlanningDateController.text.trim().substring(3, 5);
      var year = _fieldPlanningDateController.text.trim().substring(6, 10);
      if (fieldModel != null) {
        fieldModel.culture =
            CultureModel(id: cultureSelected?.id, name: cultureSelected?.name);
        fieldModel.cultureId = cultureSelected!.id;
        fieldModel.name = _fieldNameController.text.trim();
        fieldModel.farmId = selectedFarm.id;
        fieldModel.hectare = double.parse(_fieldAreaController.text.trim());
        fieldModel.planningDate = "$year-$month-${day}T12:00:00Z";
        fieldModel.soilTypeId = _soilTypeSelected!;
        fieldModel.isUpdated = 1;
        await _repository.updateFieldDb(fieldModel);
        clearFieldControllers();
        Get.back();
        Get.back();
        onFiedlSelect(fieldModel);
      } else {
        FieldModel field = FieldModel(
          culture: CultureModel(
              id: cultureSelected?.id, name: cultureSelected?.name),
          cultureId: cultureSelected!.id,
          name: _fieldNameController.text.trim(),
          farmId: selectedFarm.id,
          hectare: double.parse(_fieldAreaController.text.trim()),
          planningDate: "$year-$month-${day}T12:00:00Z",
          soilTypeId: _soilTypeSelected!,
          latitude: fieldLatitude.toString(),
          longitude: fieldLongitude.toString(),
          isSync: 0,
        );
        field.id = await _repository.saveNewFieldDb(field);
        _dataController.fields.add(field);
        _fieldList.add(field);
        clearFieldControllers();
        Get.back();
      }
    }
  }

  void changeFieldSoilType(map) {
    _soilTypeSelected = map;
  }

  void changeFieldCulture(CultureModel? culture) {
    if (culture != null) {
      _cultureSelected = culture;
    }
  }

  void getPosition() async {
    var location = await _utilsServices.getLocation();
    fieldLatitude = location.latitude;
    fieldLongitude = location.longitude;
    update();
  }

  void loadField(FieldModel field) {
    _fieldNameController.text = field.name!;
    _fieldAreaController.text = field.hectare!.toString();
    _fieldPlanningDateController.text =
        DateFormat("dd-MM-yyyy").format(DateTime.parse(field.planningDate!));
    _cultureSelected = field.culture;
    _soilTypeSelected = field.soilTypeId;

    fieldLatitude = double.parse(field.latitude!);
    fieldLongitude = double.parse(field.longitude!);
  }

  // -------------------------------------------------//
}
