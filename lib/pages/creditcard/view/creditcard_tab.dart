import 'package:financecontrol/components/custom_text_field.dart';
import 'package:financecontrol/components/customappbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../components/customcolors.dart';
import '../../expenses/controller/expenses_controller.dart';
import '../controller/creditcard_controller.dart';
import 'creditcard_screen.dart';

class CreditCardTab extends StatelessWidget {
  CreditCardTab({super.key});

  final _controller = Get.find<CreditCardController>();
  final expenseController = Get.find<ExpensesController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text('Cartões'),
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
                    child: _controller.creditList.isNotEmpty
                        ? GetBuilder<CreditCardController>(
                            builder: (controller) => ListView.builder(
                                controller: _controller.creditController,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: _controller.creditList.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                      title: Text(
                                        _controller
                                            .creditList[index].nameCreditCard!,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      subtitle: Text(
                                        'R\$ ${_controller.creditList[index].avaliableLimitCard}',
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      onTap: () {
                                        _controller.onCreditCardSelect(
                                            _controller.creditList[index]);

                                        showDialog(
                                          context: context,
                                          builder: (context) => Dialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(16)),
                                            child: Card(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16)),
                                                child: CreditCardScreen()),
                                          ),
                                        );
                                      });
                                }),
                          )
                        : const Column(
                            children: [
                              Expanded(
                                  child: Text(
                                'Não há cartões cadastrados',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              )),
                            ],
                          ),
                  ),
                ]),
              ),
              // Obx(
              //   () => Text(
              //     'Total de limite disponível: ${_controller.sum.value}',
              //     textAlign: TextAlign.center,
              //     style: const TextStyle(
              //         fontSize: 16, fontWeight: FontWeight.bold),
              //   ),
              // ),
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
                            'Novo Cartão',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          content: Form(
                            key: _controller.creditFormKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                CustomTextField(
                                  controller:
                                      _controller.nameCreditCardController,
                                  icon: Icons.credit_card,
                                  label: 'Nome do cartão: ',
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                ),
                                CustomTextField(
                                    controller:
                                        _controller.validateDateController,
                                    keyboardType: TextInputType.number,
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    label: 'Data de validade',
                                    icon: Icons.numbers),
                                CustomTextField(
                                    controller:
                                        _controller.limitValueController,
                                    keyboardType: TextInputType.number,
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    label: 'Limite total: ',
                                    icon: Icons.numbers),
                                ElevatedButton(
                                    onPressed: () {
                                      _controller.saveCredit();
                                      _controller.getCreditCard();
                                    },
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16.0)),
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
                  'Adicionar cartão',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
