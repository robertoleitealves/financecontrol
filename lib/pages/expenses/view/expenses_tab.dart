import 'package:financecontrol/components/custom_text_field.dart';
import 'package:financecontrol/components/customappbar.dart';
import 'package:financecontrol/pages/creditcard/controller/creditcard_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/customcolors.dart';
import '../../../model/credit_card_model.dart';
import '../controller/expenses_controller.dart';
import 'expense_screen.dart';

class ExpensesTab extends StatelessWidget {
  ExpensesTab({super.key});

  final _controller = Get.find<ExpensesController>();
  final _creditController = Get.find<CreditCardController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text('Despesas'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                _controller.isLoading.isFalse
                    ? Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        height: MediaQuery.of(context).size.height * 0.70,
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Column(children: [
                          Expanded(
                            child: _controller.expenseList.isNotEmpty
                                ? GetBuilder<ExpensesController>(
                                    builder: (controller) => ListView.builder(
                                      controller: _controller.expenseController,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: _controller.expenseList.length,
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          title: Text(
                                            _controller
                                                .expenseList[index].market!,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                          subtitle: Text(
                                            'R\$ ${_controller.expenseList[index].purchaseValue}',
                                            style:
                                                const TextStyle(fontSize: 16),
                                          ),
                                          onTap: () {
                                            _controller.onExpenseSelect(
                                                _controller.expenseList[index]);
                                            showDialog(
                                              context: context,
                                              builder: (context) => Dialog(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16)),
                                                child: Card(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        16)),
                                                    child: ExpenseScreen(
                                                      expense: _controller
                                                          .selectedExpense
                                                          .value,
                                                    )),
                                              ),
                                            );
                                            // Get.toNamed(
                                            //     PagesRoute.expenseSelectedRoute);
                                          },
                                        );
                                      },
                                    ),
                                  )
                                : const Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 16.0),
                                        child: Text(
                                          'Não há despesas cadastradas',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 16.0),
                                        child: Text(
                                          'Para cadastrar despesas, certifique-se de que há cartão de crédito cadastrado!',
                                          style: TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                          SizedBox(
                              child: Obx(
                            () => Text(
                              'Total: ${_controller.sumExpenses.toString()}',
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ))
                        ]),
                      )
                    : Container(
                        padding: const EdgeInsets.all(16),
                        child: const LinearProgressIndicator(
                            backgroundColor: Colors.blue),
                      ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CustomColors.customSwatchColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: ((context) {
                        return StatefulBuilder(builder: (context, setState) {
                          return SingleChildScrollView(
                            child: AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16)),
                              title: const Text(
                                'Nova despesa',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              content: Form(
                                key: _controller.expenseFormKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: GetBuilder<ExpensesController>(
                                          builder: (controller) {
                                        return DropdownButton<CreditCardModel>(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            hint:
                                                const Text('Cartão utilizado'),
                                            alignment: Alignment.center,
                                            isExpanded: true,
                                            items: _creditController.creditList
                                                .map((CreditCardModel credit) {
                                              return DropdownMenuItem<
                                                  CreditCardModel>(
                                                value: credit,
                                                child: Text(credit.name!),
                                              );
                                            }).toList(),
                                            value: _controller
                                                .creditSelected?.value,
                                            onChanged: (value) {
                                              setState(() {
                                                _controller
                                                    .selectedCard(value!);
                                              });
                                            });
                                      }),
                                    ),
                                    CustomTextField(
                                        controller:
                                            _controller.marketController,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        label: 'Empresa / Despesa',
                                        icon: Icons.business_sharp),
                                    CustomTextField(
                                        keyboardType: TextInputType.number,
                                        controller:
                                            _controller.installmentsController,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        label: 'Qtde de parcelas',
                                        icon: Icons.numbers),
                                    CustomTextField(
                                        keyboardType: TextInputType.number,
                                        controller:
                                            _controller.purchaseController,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        label: 'Valor',
                                        icon: Icons.numbers),
                                    ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            _controller.saveExpense();
                                            Get.lazyPut(
                                                () => CreditCardController());
                                            // _creditController.getCreditCard();
                                          });
                                        },
                                        style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(16)),
                                            backgroundColor:
                                                CustomColors.customSwatchColor),
                                        child: const Text(
                                          'Cadastrar',
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextButton(
                                        child: Text(
                                          'Retornar',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: CustomColors
                                                  .customContrastColor),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                      }),
                    );
                  },
                  child: const Text(
                    'Adicionar despesa',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
