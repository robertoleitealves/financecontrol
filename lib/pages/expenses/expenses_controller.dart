import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ExpensesController extends GetxController {
  List<String> pay = ['C6', 'Nubank', 'Next'];
  List<Map> expenses = [
    {
      'market': 'Casa da Mãe Joana',
      'expense': 'Bebidas',
      'payment': 'Next',
      'installments': 1,
      'purchaseValue': 50.00,
      'date': '2023-03-11'
    },
    {
      'market': 'Bar Joaquina',
      'expense': 'Bebidas',
      'payment': 'NuBank',
      'installments': 1,
      'purchaseValue': 70.00,
      'date': '2023-03-18'
    },
    {
      'market': 'Savegnago',
      'expense': 'Compras',
      'payment': 'C6',
      'installments': 1,
      'purchaseValue': 56.5,
      'date': '2023-04-20'
    }
  ];
  Map? expenseSelected;
  RxDouble? totalValue;
  String? selectedPay;
  String? selectedMarket;
  ScrollController controller = ScrollController();

  calcTotal() {
    totalValue =
        expenses[0]['value'] + expenses[1]['value'] + expenses[2]['value'].obs;
  }
}
