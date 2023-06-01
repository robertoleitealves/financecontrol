import 'package:financecontrol/components/customcolors.dart';
import 'package:financecontrol/model/expenses_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/expenses_controller.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({super.key, required ExpensesModel expense});

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
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
                _controller.selectedExpense.value.market!,
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
                  TextSpan(text: _controller.selectedExpense.value.createdAt),
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
                  TextSpan(
                      text: _controller.selectedExpense.value.creditCard?.name),
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
                      text: _controller.selectedExpense.value.installments
                          .toString())
                ],
              ),
              style: const TextStyle(fontSize: 16),
            ),
            Obx(
              () => Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Valor da parcela: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                        text: _controller.selectedExpense.value.purchaseValue
                            .toString())
                  ],
                ),
                style: const TextStyle(fontSize: 16),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: _controller.selectedExpense.value.installments! <= 1
                  ? ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _controller.deleteExpenseDb(
                              _controller.selectedExpense.value.id!);
                        });

                        // _controller.sumExpenses.value = _controller
                        //         .sumExpenses.value -
                        //     _controller.selectedExpense.value.purchaseValue!;
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          backgroundColor: CustomColors.customSwatchColor),
                      child: const Text(
                        'Apagar despesa',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    )
                  : ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _controller
                              .slaughterplot(_controller.selectedExpense.value);
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          backgroundColor: CustomColors.customSwatchColor),
                      child: const Text(
                        'Abater parcela',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
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
