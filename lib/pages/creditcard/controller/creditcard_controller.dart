import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class CreditCardController extends GetxController {
  List creditCardList = [
    {
      'creditCard': 'Nubank',
      'avaliableLimit': 48.5,
      'expensesValue': 151.5,
      'valueLimit': 200.0,
      'expensesCard': [
        {
          'market': 'Casa da Mãe Joana',
          'object': 'Bebidas',
          'date': '13/04/2022',
          'value': 30,
          'installments': 01
        },
        {
          'market': 'Irmãos Patrocínio',
          'object': 'Compras',
          'date': '02/04/2022',
          'value': 75,
          'installments': 01
        },
        {
          'market': 'Becks',
          'object': 'Cerveja',
          'date': '07/04/2022',
          'value': 36.5,
          'installments': 01
        }
      ]
    },
    {
      'creditCard': 'C6',
      'avaliableLimit': 50.0,
      'expensesValue': 150.0,
      'valueLimit': 200.0,
      'expensesCard': [
        {
          'market': 'Casa da Mãe Joana',
          'object': 'Bebidas',
          'date': '13/04/2022',
          'value': 30,
          'installments': 01
        },
        {
          'market': 'Irmãos Patrocínio',
          'object': 'Compras',
          'date': '02/04/2022',
          'value': 75,
          'installments': 01
        },
        {
          'market': 'Becks',
          'object': 'Cerveja',
          'date': '07/04/2022',
          'value': 36.5,
          'installments': 01
        }
      ]
    },
    {
      'creditCard': 'Next',
      'avaliableLimit': 30.0,
      'expensesValue': 120.0,
      'valueLimit': 150.0,
      'expensesCard': [
        {
          'market': 'Casa da Mãe Joana',
          'object': 'Bebidas',
          'date': '13/04/2022',
          'value': 30,
          'installments': 01
        },
        {
          'market': 'Irmãos Patrocínio',
          'object': 'Compras',
          'date': '02/04/2022',
          'value': 75,
          'installments': 01
        },
        {
          'market': 'Becks',
          'object': 'Cerveja',
          'date': '07/04/2022',
          'value': 36.5,
          'installments': 01
        }
      ]
    },
  ];

  Map? creditCardSelected;
  double sum = 128.5;
  final controller = ScrollController();

  Future creditCardSelect(Map itemSelected) async {
    creditCardSelected = itemSelected;

    update();
  }

  Future getAllCreditCards() async {}
  Future insertCreditCard() async {}
  Future updateCreditCard() async {}
  Future deleteCreditCard() async {}
}
