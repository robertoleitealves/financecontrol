import 'package:financecontrol/components/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../components/customcolors.dart';
import '../controller/creditcard_controller.dart';

class CreditCardScreen extends StatelessWidget {
  CreditCardScreen({super.key});
  final _controller = Get.find<CreditCardController>();

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
                _controller.selectedCreditCard!.value.name!,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: CustomColors.customSwatchColor),
              ),
            ),
            // Text.rich(
            //   TextSpan(
            //     children: [
            //       const TextSpan(
            //           text: 'Quantidade de despesas: ',
            //           style: TextStyle(fontWeight: FontWeight.bold)),
            //       TextSpan(text: _controller.qtExpenses.toString())
            //     ],
            //   ),
            //   style: const TextStyle(fontSize: 16),
            // ),
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                      text: 'Limite total: ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: _controller.selectedCreditCard!.value.limitValue
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
                      text: _controller.selectedCreditCard!.value.avaliableLimit
                          .toString())
                ],
              ),
              style: const TextStyle(fontSize: 16),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: ((context) {
                      return StatefulBuilder(builder: (context, setState) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          title: const Text(
                            'Alteração de limite total do cartão',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  'Caso deseje alterar o limite total do cartão, digite o novo valor abaixo, caso contrário, clique no botão retornar!',
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              CustomTextField(
                                label: 'Digite o novo valor de limite',
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                icon: Icons.money,
                                controller: _controller.newLimitValueController,
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    _controller.updateCreditCard(
                                        _controller.selectedCreditCard!.value);
                                    Get.back();
                                    Get.back();
                                  },
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16.0)),
                                      backgroundColor:
                                          CustomColors.customSwatchColor),
                                  child: const Text(
                                    'Atualizar',
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
                        );
                      });
                    }),
                  );
                },
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
              onPressed: () {
                showDialog(
                  context: context,
                  builder: ((context) {
                    return StatefulBuilder(builder: (context, setState) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        title: const Text(
                          'Tem certeza que deseja apagar?',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                'Após a confirmação de exclusão, todos os dados referentes a este cartão serão excluídos do sistema!',
                                textAlign: TextAlign.justify,
                              ),
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  _controller.deleteCreditCardDb(
                                      _controller.selectedCreditCard!.value.id!);
                                  Get.back();
                                  Get.back();
                                },
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(16.0)),
                                    backgroundColor:
                                        CustomColors.customSwatchColor),
                                child: const Text(
                                  'Apagar',
                                )),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextButton(
                                child: Text(
                                  'Retornar',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: CustomColors.customContrastColor),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    });
                  }),
                );
              },
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
