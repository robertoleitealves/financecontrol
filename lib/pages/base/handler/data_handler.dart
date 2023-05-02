// import 'dart:developer';

// import 'package:financecontrol/model/expenses_model.dart';
// import 'package:izconsultores/src/models/dto/farm_model_dto.dart';
// import 'package:izconsultores/src/models/dto/field_model_dto.dart';
// import 'package:izconsultores/src/models/dto/producer_model_dto.dart';
// import 'package:izconsultores/src/pages/auth/result/auth_result.dart';

// import '../../../constants/constants.dart';
// import '../../../model/credit_card_model.dart';
// import '../../../model/user_model.dart';


// class DataHandler {
//   final HttpManager _httpManager = HttpManager();

//   Future getAllProducers(String token, UserModel user) async {
//     try {
//       List<ProducerModel> producerList = [];
//       final response = await _httpManager.restRequest(
//           url: Endpoints.getExpenses,
//           method: HttpMethods.get,
//           headers: {"Authorization": "Bearer $token"});
//       expensesList = response.map<ExpensesModel>((expenses) {
//         expense["isSync"] = 1;
//         expense['user'] = user.toJson();
//         return ExpensesModel.fromJson(expense);
//       }).toList();
//       return producerList;
//     } catch (err) {
//       if (err is int) {
//         throw Error(responseErrors(err));
//       }
//       return <ExpensesModel>[];
//     }
//   }

//   Future getAllFarms(int creditCardId, String token) async {
//     try {
//       List<CreditCardModel> farmList = [];
//       final response = await _httpManager.restRequest(
//         url: Endpoints.getFarms + '/$creditCardId',
//         method: HttpMethods.get,
//         headers: {"Authorization": "Bearer $token"},
//       );
//       farmList = response.map<FarmModel>((farm) {
//         farm["isSync"] = 1;
//         creditCardId["userId"] = producerId;
//         return CreditCardModel.fromJson(farm);
//       }).toList();
//       return farmList;
//     } catch (err) {
//       if (err is int) {
//         throw Error(responseErrors(err));
//       }
//       return <CreditCardModel>[];
//     }
//   }

  

  

//   // EXPENSES
//   // Future<ExpensesModel?> saveExpenses(
//   //     ExpensesModel producer, String token) async {
//   //   ExpensesModelDto body = ExpensesModelDto.fromEntity(producer);
//   //   try {
//   //     if (producer.isUpdated == 1) {
//   //       var response = await _httpManager.restRequest(
//   //         url: Endpoints.saveProducer,
//   //         method: HttpMethods.put,
//   //         headers: {"Authorization": "Bearer $token"},
//   //         body: body.toJson(),
//   //       );
//   //       ExpensesModel result =
//   //           ExpensesModel.fromDTO(ExpensesModelDto.fromJson(response));
//   //       return result;
//   //     } else {
//   //       body.id = null;
//   //       var response = await _httpManager.restRequest(
//   //         url: Endpoints.saveExpenses,
//   //         method: HttpMethods.post,
//   //         headers: {"Authorization": "Bearer $token"},
//   //         body: body.toJson(),
//   //       );
//   //       var aux = ExpensesModelDto.fromJson(response);
//   //       ExpensesModel result = ExpensesModel.fromDTO(aux);
//   //       return result;
//   //     }
//   //   } on ErrorRequest catch (err, s) {
//   //     log("Erro na requisição",
//   //         name: "saveProducer", error: err, stackTrace: s);

//   //     return null;
//   //   }
//   // }

//   // Future<void> deleteExpense(int producerId, String token) async {
//   //   try {
//   //     await _httpManager.restRequest(
//   //       url: Endpoints.deleteProducer + '/$producerId',
//   //       method: HttpMethods.delete,
//   //       headers: {"Authorization": "Bearer $token"},
//   //     );
//   //   } on ErrorRequest catch (e, s) {
//   //     log('Erro ao deletar produtor',
//   //         name: 'deleteProducer', error: e, stackTrace: s);
//   //     throw responseErrors(e.statusCode);
//   //   }
//   // }

//   // // FARM
//   // Future<CreditCardModel?> saveFarm(CreditCardModel farm, String token) async {
//   //   CreditCardModelDTO body = CreditCardModelDTO.fromEntity(farm);

//   //   try {
//   //     if (farm.isUpdated == 1) {
//   //       // UPDATE FARM
//   //       final response = await _httpManager.restRequest(
//   //         url: Endpoints.saveFarm,
//   //         method: HttpMethods.put,
//   //         headers: {"Authorization": "Bearer $token"},
//   //         body: body.toJson(),
//   //       );
//   //       CreditCardModel result = CreditCardModel.fromDTO(CreditCardModelDTO.fromJson(response));
//   //       result.producerId = farm.producerId;
//   //       result.userId = farm.userId;
//   //       return result;
//   //     } else {
//   //       // NEW FARM
//   //       body.id = null;
//   //       final response = await _httpManager.restRequest(
//   //         url: Endpoints.saveFarm,
//   //         method: HttpMethods.post,
//   //         headers: {"Authorization": "Bearer $token"},
//   //         body: body.toJson(),
//   //       );
//   //       FarmModel result = FarmModel.fromDTO(FarmModelDTO.fromJson(response));
//   //       result.producerId = farm.producerId;
//   //       result.userId = farm.userId;
//   //       return result;
//   //     }
//   //   } catch (err, s) {
//   //     log("Erro na requisição", name: "saveFarm", error: err, stackTrace: s);
//   //     if (err is int) {
//   //       throw Error(responseErrors(err));
//   //     }
//   //     return null;
//   //   }
//   // }

//   Future<void> deleteCreditCard(int creditCardId, String token) async {
//     try {
//       await _httpManager.restRequest(
//         url: Endpoints.deleteCreditCard + '/$creditCardId',
//         method: HttpMethods.delete,
//         headers: {"Authorization": "Bearer $token"},
//       );
//     } on ErrorRequest catch (e, s) {
//       log('Erro ao deletar fazenda',
//           name: 'deleteFarm', error: e, stackTrace: s);
//       throw responseErrors(e.statusCode);
//     }
//   }

//   // FIELD
 
// }
