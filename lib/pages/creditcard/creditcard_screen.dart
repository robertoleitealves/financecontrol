import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/customappbar.dart';
import 'creditcard_controller.dart';

class CreditCardScreen extends StatelessWidget {
  CreditCardScreen({super.key});
  final _controller = Get.find<CreditCardController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        automaticallyImplyLeading: true,
        title: Text(_controller.creditCardSelected!['creditCard']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                      text: 'Dia: ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: _controller.creditCardSelected!['date'])
                ],
              ),
              style: const TextStyle(fontSize: 16),
            ),
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                      text: 'Qtde Despesas: ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: _controller.creditCardSelected!['expenses'].lenght
                          .toString())
                ],
              ),
              style: const TextStyle(fontSize: 16),
            ),
            // Text.rich(
            //   TextSpan(
            //     children: [
            //       const TextSpan(
            //           text: 'Forma de pagamento: ',
            //           style: TextStyle(fontWeight: FontWeight.bold)),
            //       TextSpan(text: _controller.creditCardSelected!['payment']),
            //     ],
            //   ),
            //   style: const TextStyle(fontSize: 16),
            // ),
            // Text.rich(
            //   TextSpan(
            //     children: [
            //       const TextSpan(
            //           text: 'Parcelas: ',
            //           style: TextStyle(fontWeight: FontWeight.bold)),
            //       TextSpan(
            //           text: _controller.creditCardSelected!['installments']
            //               .toString())
            //     ],
            //   ),
            //   style: TextStyle(fontSize: 16),
            // ),
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                    text: 'Valor total: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                      text: _controller.creditCardSelected!['purchaseValue']
                          .toString())
                ],
              ),
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
