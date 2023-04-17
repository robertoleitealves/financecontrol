import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/customappbar.dart';
import 'market_controller.dart';

class MarketScreen extends StatelessWidget {
  MarketScreen({super.key});
  final _controller = Get.find<MarketController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        automaticallyImplyLeading: true,
        title: Text(_controller.marketSelected!['market']),
      ),
      body: _controller.loading == false.obs
          ? SingleChildScrollView(
              child: Padding(
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
                            TextSpan(text: _controller.marketSelected!['date'])
                          ],
                        ),
                        style: const TextStyle(fontSize: 16)),
                    Text.rich(
                      TextSpan(
                        children: [
                          const TextSpan(
                              text: 'Qtde Despesas: ',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(
                              text: _controller
                                  .marketSelected!['expensePlan'].lenght
                                  .toString())
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
                              text: _controller.marketSelected!['payment']),
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
                              text: _controller.marketSelected!['installments']
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
                              text: _controller.marketSelected!['purchaseValue']
                                  .toString())
                        ],
                      ),
                      style: const TextStyle(fontSize: 16),
                    ),
                    GetBuilder<MarketController>(
                        builder: (controller) => _controller
                                    .marketSelected!['expensesPlan'].length !=
                                null
                            ? ListView.builder(
                                controller: _controller.controllerMarket,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: _controller
                                    .marketSelected!['expensesPlan'].length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                      title: Text(
                                        _controller.marketSelected![index]
                                            ['object'],
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      subtitle: Column(
                                        children: [
                                          Text(
                                            'Data:  ${_controller.marketSelected![index]['date']}',
                                            style:
                                                const TextStyle(fontSize: 16),
                                          ),
                                          Text(
                                            'Data:  ${_controller.marketSelected![index]['value']}',
                                            style:
                                                const TextStyle(fontSize: 16),
                                          ),
                                        ],
                                      ),
                                      onTap: () {});
                                })
                            : const Text('Não há despesas nesse crediário')),
                  ],
                ),
              ),
            )
          : const CircularProgressIndicator(),
    );
  }
}
