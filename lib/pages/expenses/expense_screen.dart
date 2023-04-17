import 'package:financecontrol/components/customcolors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'expenses_controller.dart';

class ExpenseScreen extends StatelessWidget {
  ExpenseScreen({super.key});
  final _controller = Get.find<ExpensesController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      // height: MediaQuery.of(context).size.height,
      // width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(
                _controller.expenseSelected!['market'],
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
                      text: 'Dia: ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: _controller.expenseSelected!['date'])
                ],
              ),
              style: const TextStyle(fontSize: 16),
            ),
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                      text: 'Despesa: ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: _controller.expenseSelected!['expense'])
                ],
              ),
              style: const TextStyle(fontSize: 16),
            ),
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                      text: 'Forma de pagamento: ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: _controller.expenseSelected!['payment']),
                ],
              ),
              style: const TextStyle(fontSize: 16),
            ),
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                      text: 'Parcelas: ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: _controller.expenseSelected!['installments']
                          .toString())
                ],
              ),
              style: const TextStyle(fontSize: 16),
            ),
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                    text: 'Valor: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                      text: _controller.expenseSelected!['purchaseValue']
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
                  'Apagar despesa',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
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
