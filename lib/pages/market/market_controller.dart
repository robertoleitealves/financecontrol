import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class MarketController extends GetxController {
  List? marketList = [
    {
      'market': 'Magazine Luiza',
      'avaliableLimit': 50.0,
      'valueLimit': 650.0,
      'expensesPlan': [
        {
          'object': 'roupas',
          'date': '13/04/2022',
          'value': 600,
          'installments': 10
        }
      ]
    },
    {
      'market': 'Casas Bahia',
      'avaliableLimit': 50.0,
      'valueLimit': 200.0,
      'expensesPlan': [
        {
          'object': 'fritadeira',
          'date': '13/01/2022',
          'value': 200,
          'installments': 5
        }
      ]
    },
    {
      'market': 'Riachuelo',
      'avaliableLimit': 30.0,
      'valueLimit': 150.0,
      'expensesPlan': [
        {
          'object': 'roupas',
          'date': '10/03/2022',
          'value': 120,
          'installments': 02
        }
      ]
    },
  ];
  Map? marketSelected;
  final controller = ScrollController();
  final controllerMarket = ScrollController();
  RxBool loading = false.obs;

  Future itemSelected(item) async {
    marketSelected = item;
    update();
  }
}
