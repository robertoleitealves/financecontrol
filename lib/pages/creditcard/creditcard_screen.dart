import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/customappbar.dart';
import '../../components/customcolors.dart';
import 'creditcard_controller.dart';

class CreditCardScreen extends StatelessWidget {
  CreditCardScreen({super.key});
  final _controller = Get.find<CreditCardController>();

  sumCredits() {
    for (var i = 0; i == _controller.creditCardList.length; i++) {
      _controller.sum += _controller.creditCardList[i]['expensesValue'];
    }
    _controller.sum;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
  
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(
                _controller.creditCardSelected!['creditCard'],
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: CustomColors.customSwatchColor),
              ),
            ),
          

            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                      text: 'Quantidade de despesas: ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: _controller
                          .creditCardSelected!['expensesCard'].length
                          .toString())
                ],
              ),
              style: const TextStyle(fontSize: 16),
            ),
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                      text: 'Limite total: ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: _controller.creditCardSelected!['valueLimit']
                          .toString()),
                ],
              ),
              style: const TextStyle(fontSize: 16),
            ),
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                    text: 'Limite disponível: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                      text: _controller.creditCardSelected!['avaliableLimit']
                          .toString())
                ],
              ),
              style: const TextStyle(fontSize: 16),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    backgroundColor: CustomColors.customSwatchColor),
                child: const Text(
                  'Alterar dados do cartão',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  backgroundColor: CustomColors.customContrastColor),
              child: const Text(
                'Apagar cartão',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Voltar',
                style: TextStyle(
                    color: CustomColors.customContrastColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            )
          ],
        ),
      ),
    );
  }
}
