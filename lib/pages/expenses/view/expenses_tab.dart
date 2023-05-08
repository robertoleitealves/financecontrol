import 'package:financecontrol/components/custom_text_field.dart';
import 'package:financecontrol/components/customappbar.dart';


import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../../components/customcolors.dart';
import '../controller/expenses_controller.dart';
import 'expense_screen.dart';

class ExpensesTab extends StatelessWidget {
  ExpensesTab({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _controller = Get.find<ExpensesController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text('Despesas'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                height: MediaQuery.of(context).size.height * 0.70,
                width: MediaQuery.of(context).size.width * 0.5,
                child: Column(children: [
                  Expanded(
                    child: GetBuilder<ExpensesController>(
                      builder: (controller) => ListView.builder(
                        controller: _controller.controller,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: _controller.expenses.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              _controller.expenses[index]['market'],
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            subtitle: Text(
                              'R\$ ${_controller.expenses[index]['purchaseValue']}',
                              style: const TextStyle(fontSize: 16),
                            ),
                            onTap: () {
                              _controller.expenseSelected =
                                  _controller.expenses[index];
                              showDialog(
                                context: context,
                                builder: (context) => Dialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16)),
                                  child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                      child: ExpenseScreen()),
                                ),
                              );
                              // Get.toNamed(
                              //     PagesRoute.expenseSelectedRoute);
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    child: Text(
                      'Total: ${_controller.totalValue?.toString()}',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  )
                ]),
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
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          title: const Text(
                            'Nova despesa',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          content: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: DropdownButton(
                                      borderRadius: BorderRadius.circular(16),
                                      hint: const Text('Cartão utilizado'),
                                      alignment: Alignment.center,
                                      isExpanded: true,
                                      items: _controller.pay
                                          .map<DropdownMenuItem<String>>(
                                              (value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        _controller.selectedPay = value;
                                      }),
                                ),
                               const  CustomTextField(
                                    padding:
                                         EdgeInsets.symmetric(vertical: 8),
                                    label: 'Empresa',
                                    icon: Icons.business_sharp),
                                const CustomTextField(
                                    padding:
                                         EdgeInsets.symmetric(vertical: 8),
                                    label: 'Qtde de parcelas',
                                    icon: Icons.numbers),
                               const  CustomTextField(
                                    padding:
                                         EdgeInsets.symmetric(vertical: 8),
                                    label: 'Valor',
                                    icon: Icons.numbers),
                                ElevatedButton(
                                    onPressed: () {},
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
                                          color:
                                              CustomColors.customContrastColor),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ),
                              ],
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
    );
  }
}
