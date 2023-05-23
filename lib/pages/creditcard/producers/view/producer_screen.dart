import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:izconsultores/src/config/app_constants.dart';
import 'package:izconsultores/src/pages/common_widget/custom_app_bar.dart';
import 'package:izconsultores/src/pages/producers/components/create_producer_dialog.dart';
import 'package:izconsultores/src/pages/producers/controller/producer_controller.dart';

import '../../../models/models.dart';

class ProducerScreen extends StatelessWidget {
  ProducerScreen({Key? key}) : super(key: key);

  final _controller = Get.find<ProducerController>();

  @override
  Widget build(BuildContext context) {
    int _filterSelected = 1;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: CustomAppBar(
        title: const Text('Gerenciar produtores'),
        actions: [
          PopupMenuButton<int>(
              icon: const Icon(Icons.sort_by_alpha),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              onSelected: (value) {
                _filterSelected = value;
                _controller.sortFilter(value);
              },
              itemBuilder: (context) => <PopupMenuEntry<int>>[
                    PopupMenuItem(
                      child: Text(
                        'A-Z',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color:
                              _filterSelected == 1 ? colorScheme.primary : null,
                        ),
                      ),
                      value: 1,
                    ),
                    PopupMenuItem(
                      child: Text(
                        'Z-A',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color:
                              _filterSelected == 2 ? colorScheme.primary : null,
                        ),
                      ),
                      value: 2,
                    ),
                    PopupMenuItem(
                      child: Text(
                        'Mais recentes',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color:
                              _filterSelected == 3 ? colorScheme.primary : null,
                        ),
                      ),
                      value: 3,
                    ),
                    PopupMenuItem(
                      child: Text(
                        'Mais antigos',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color:
                              _filterSelected == 4 ? colorScheme.primary : null,
                        ),
                      ),
                      value: 4,
                    ),
                  ])
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => const CreateProducerDialog(),
            );
          },
          label: const Text('Novo produtor')),
      body: Container(
        color: colorScheme.background,
        padding: const EdgeInsets.all(16),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              SizedBox(
                child: Column(
                  children: [
                    Text(
                      "Produtores cadastrados",
                      style: TextStyle(
                        color: colorScheme.primary,
                        fontSize: AppStyles.titleFontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      "Toque em um produtor existente para adicionar uma nova fazenda ou adicione um novo produtor.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: AppStyles.bodyFontSize,
                      ),
                    ),
                  ],
                ),
              ),

              // SEARCH BOX
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: TextField(
                  controller: _controller.searchProducerController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: colorScheme.surface,
                    hintText: "Procurar produtor",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    isDense: true,
                    prefixIcon: const Icon(
                      Icons.search,
                      size: 26,
                    ),
                    suffixIcon:
                        _controller.searchProducerController.value.text != ""
                            ? IconButton(
                                icon: const Icon(Icons.cancel),
                                onPressed: _controller.clearSearchBoxProducer,
                              )
                            : null,
                  ),
                  onChanged: _controller.activeFilter,
                ),
              ),

              // BODY
              Expanded(
                child: Visibility(
                  visible: _controller.producerList.isNotEmpty,
                  child: ListView.builder(
                    padding: const EdgeInsets.only(bottom: 32),
                    physics: const BouncingScrollPhysics(),
                    itemCount: _controller.producerList.length,
                    itemBuilder: (context, index) {
                      return _ProducerCard(
                        controller: _controller,
                        colorScheme: colorScheme,
                        producerModel: _controller.producerList[index],
                      );
                    },
                  ),
                  replacement: const Center(
                    child: Text(
                      "Nenhum produtor encontrado!",
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProducerCard extends StatelessWidget {
  const _ProducerCard({
    Key? key,
    required ProducerController controller,
    required this.producerModel,
    required this.colorScheme,
  })  : _controller = controller,
        super(key: key);

  final ProducerController _controller;
  final ColorScheme colorScheme;
  final ProducerModel producerModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _controller.openProducerDetails(
        producerModel,
      ),
      child: Card(
        margin: const EdgeInsets.only(bottom: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.person,
                  size: 32,
                  color: colorScheme.primary,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      producerModel.firstName!,
                      style: const TextStyle(
                        fontSize: AppStyles.subtitleFontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      producerModel.lastName!,
                      style: const TextStyle(
                        fontSize: AppStyles.bodyFontSize,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        producerModel.isCnpj == 0
                            ? 'Pessoa Física'
                            : 'Pessoa Jurídica',
                        style: TextStyle(
                          color: colorScheme.secondary,
                          fontSize: AppStyles.smallBodyFontSize,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  producerModel.isSync == 1
                      ? Icons.cloud_done
                      : Icons.cloud_off,
                  color: producerModel.isSync == 1
                      ? Colors.green.shade800
                      : Colors.red,
                ),
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
