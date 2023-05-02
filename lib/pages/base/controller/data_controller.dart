// import 'dart:developer';

// import 'package:financecontrol/model/credit_card_model.dart';
// import 'package:financecontrol/model/user_model.dart';
// import 'package:financecontrol/pages/base/handler/data_handler.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:get/get.dart';

// import '../../../model/expenses_model.dart';
// import '../repository/data_repository.dart';

// class DataController extends GetxController {
//   // final ConnectivityController _connectivity =
//   //     Get.find<ConnectivityController>();
//   final DataRepository _repository = DataRepository();
//   // final DataHandler _handler = DataHandler();

//   UserModel _user = UserModel();
//   String? _token;
//   bool _isLoading = true;

//   UserModel get user => _user;
//   List<ExpensesModel> get expenses => _expenses;
//   List<CreditCardModel> get creditcard => _creditcard;

//   @override
//   onInit() {
//     super.onInit();
//     loadData().then((value) => _checkUnsychronizedData());
//   }

//   // Future<void> loadData() async {
//   //   _user = await _repository.getUserModelDB();
//   //   _token = await _repository.getTokenDb();
//   //   _expenses = await _repository.getExpensesListDb();
//   //   _creditcard = await _repository.getCreditCardListDb();

//   //   if (_expenses.isEmpty) {
//   //     _expenses = await _handler.getAllProducers(_token!, _user);
//   //     await _repository.saveExpensesListDb(_expenses);

//   //     // for (var expense in _expenses) {
//   //     //   List<CreditCardModel> creditCardList = expense.payment!;
//   //     //   for (var farm in farmList) {
//   //     //     farm.producerId = producer.id;
//   //     //     farm.isSync = 1;
//   //     //     if (farm.listField != null) {
//   //     //       List<FieldModel> fieldList = [];
//   //     //       for (var field in farm.listField!) {
//   //     //         field.farmId = farm.id;
//   //     //         field.isSync = 1;
//   //     //         fieldList.add(field);
//   //     //       }
//   //     //       _fields.addAll(fieldList);
//   //     //       await _repository.saveFieldsListDb(fieldList);
//   //     //     }
//   //     //   }
//   //     //   await _repository.saveFarmsListDb(farmList);
//   //     //   _farms.addAll(farmList);
//   //     // }

//   //     debugPrint("-- Dados Producer/Farm/Field carregados! --");
//   //   }
//   //   await _verifyHasData();
//   // }
//   // _isLoading = false;
//   // update();

//   // Future<void> _verifyHasData() async {
//   //   try {
//   //     if (_producers.isEmpty) {
//   //       _producers = await _handler.getAllProducers(token, user);
//   //       if (_producers.isEmpty) return;
//   //     }
//   //     if (_farms.isEmpty) {
//   //       for (var producer in _producers) {
//   //         List _farmsAux = await _handler.getAllFarms(producer.id!, token);
//   //         await _repository.saveFarmsListDb(_farmsAux as List<FarmModel>);
//   //         _farms.addAll(_farmsAux);
//   //       }
//   //     }
//   //     if (_fields.isEmpty) {
//   //       for (var farm in _farms) {
//   //         List _fieldsAux = await _handler.getAllFields(farm.id!, token);
//   //         await _repository.saveFieldsListDb(_fieldsAux as List<FieldModel>);
//   //         _fields.addAll(_fieldsAux);
//   //       }
//   //     }
//   //   } catch (e) {
//   //     Get.snackbar('Erro', e.toString());
//   //   }
//   // }

//   Future<void> _checkUnsychronizedData() async {
//     List<ExpensesModel> unsychronizedExpenses =
//         _expenses.where((expense) => expense.isSync == 0).toList();
//     List<CreditCardModel> unsychronizedCreditCard =
//         _creditCard.where((creditCard) => creditCard.isSync == 0).toList();

//     debugPrint('Producers unsync: ${unsychronizedProducers.length}');
//     debugPrint('Farms unsync: ${unsychronizedFarms.length}');
//     debugPrint('Fields unsync: ${unsychronizedFields.length}');

//     if (_connectivity.isConnected) {
//       // SYNC PRODUCERS
//       for (ProducerModel producerModel in unsychronizedProducers) {
//         try {
//           final response = await _handler.saveProducer(producerModel, _token!);
//           if (response != null) {
//             response.user = user;
//             response.isSync = 1;
//             await _repository.updateProducerDb(response);
//           }
//         } catch (e, s) {
//           log('Erro ao fazer update DB',
//               name: "updateProducerDB", error: e, stackTrace: s);
//         }
//       }
//       unsychronizedProducers.isNotEmpty ? loadData() : null;

//       // SYNC FARMS
//       for (FarmModel farmModel in unsychronizedFarms) {
//         var validateProducer =
//             _producers.where((element) => farmModel.producerId == element.id);
//         // Validar se o produtor já está sincronizado
//         if (validateProducer.first.isSync == 1) {
//           try {
//             final response = await _handler.saveFarm(farmModel, _token!);
//             if (response != null) {
//               await _repository.updateFarmDb(response);
//             }
//           } catch (e, s) {
//             log('Erro ao fazer update DB',
//                 name: "updateFarmDB", error: e, stackTrace: s);
//           }
//         }
//       }
//       unsychronizedFarms.isNotEmpty ? loadData() : null;

//       //TODO: CORRIGIR A SINCRONIZAÇÃO DOS FIELDS

//       // SYNC FIELDS
//       if (unsychronizedFields.isNotEmpty) {
//         List<FieldModel> updateList = [];
//         List<FieldModel> newFielList = [];
//         for (FieldModel field in unsychronizedFields) {
//           if (field.isUpdated == 1) {
//             updateList.add(field);
//           } else {
//             newFielList.add(field);
//           }
//         }
//         if (updateList.isNotEmpty) {
//           try {
//             final response = await _handler.saveField(
//                 fieldList: updateList, token: _token!, isUpdate: true);
//             if (response != null) {
//               await _repository.updateFieldDb(response);
//             }
//           } catch (e, s) {
//             log('Erro ao fazer update DB',
//                 name: "updateFieldDB", error: e, stackTrace: s);
//           }
//         }
//         if (newFielList.isNotEmpty) {
//           try {
//             final response = await _handler.saveField(
//                 fieldList: newFielList, token: _token!);
//             if (response != null) {
//               await _repository.updateFieldDb(response);
//             }
//           } catch (e, s) {
//             log('Erro ao fazer update DB',
//                 name: "updateFieldDB", error: e, stackTrace: s);
//           }
//         }
//       }
//       unsychronizedFields.isNotEmpty ? loadData() : null;
//     }
//   }
// }
