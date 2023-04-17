import 'package:financecontrol/components/customappbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/customTextField.dart';
import '../../components/customcolors.dart';
import '../../routes/app_routes.dart';
import 'market_controller.dart';

class MarketTab extends StatelessWidget {
  MarketTab({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _controller = Get.find<MarketController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text('Lojas'),
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
                    child: GetBuilder<MarketController>(
                        builder: (controller) => ListView.builder(
                            controller: _controller.controller,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: _controller.marketList!.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                  title: Text(
                                    _controller.marketList![index]['market'],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  subtitle: Text(
                                    'R\$ ${_controller.marketList![index]['avaliableLimit']}',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  onTap: () async {
                                    _controller.loading = true.obs;
                                    await _controller.itemSelected(
                                        _controller.marketList![index]);
                                    _controller.loading = false.obs;
                                    Get.toNamed(PagesRoute.marketSelectedRoute);
                                  });
                            })),
                  ),
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
                            'Novo crediário',
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
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 0, 8, 8),
                                  child: DropdownButton(
                                      borderRadius: BorderRadius.circular(16),
                                      hint: const Text('Selecione...'),
                                      alignment: Alignment.center,
                                      isExpanded: true,
                                      items: _controller.marketList!
                                          .map<DropdownMenuItem<String>>(
                                              (value) {
                                        return DropdownMenuItem<String>(
                                          value: value['market'],
                                          child: Text(value['market']),
                                        );
                                      }).toList(),
                                      onChanged: (market) {
                                        _controller.marketSelected!['market'] =
                                            market;
                                      }),
                                ),
                                const CustomTextField(
                                    keyboardType: TextInputType.number,
                                    padding: EdgeInsets.symmetric(vertical: 8),
                                    label: 'Qtde de parcelas',
                                    icon: Icons.numbers),
                                const CustomTextField(
                                    keyboardType: TextInputType.number,
                                    padding: EdgeInsets.symmetric(vertical: 8),
                                    label: 'Valor',
                                    icon: Icons.numbers),
                                ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            CustomColors.customSwatchColor),
                                    child: const Text(
                                      'Cadastrar',
                                    )),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          CustomColors.customContrastColor),
                                  child: const Text('Voltar'),
                                )
                              ],
                            ),
                          ),
                        );
                      });
                    }),
                  );
                },
                child: const Text(
                  'Adicionar crediário',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
