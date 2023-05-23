import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:izconsultores/src/models/models.dart';
import 'package:izconsultores/src/pages/common_widget/common_widget.dart';
import 'package:izconsultores/src/pages/producers/components/create_farm_dialog.dart';
import 'package:izconsultores/src/pages/producers/components/create_field_dialog.dart';
import 'package:izconsultores/src/pages/producers/controller/producer_controller.dart';

import '../../../config/config.dart';
import '../components/create_producer_dialog.dart';

class ProducerDetails extends StatelessWidget {
  final ProducerModel producer;

  ProducerDetails({required this.producer, Key? key}) : super(key: key);

  final _producerController = Get.find<ProducerController>();

  @override
  Widget build(BuildContext context) {
    _producerController.setProducer = producer;
    _producerController.selectedProducer.listFarm ??= [];

    ColorScheme _colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: CustomAppBar(
        title: const Text(
          "Detahes do Produtor",
        ),
      ),
      body: Obx(
        () => SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                // PRODUCER INFO
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 16,
                        ),
                        child: CircleAvatar(
                          maxRadius: 40,
                          backgroundColor: _colorScheme.surfaceVariant,
                          backgroundImage: const AssetImage(
                            AppAssets.appLogo,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                "${_producerController.selectedProducer.firstName} ${_producerController.selectedProducer.lastName}",
                                style: const TextStyle(
                                  fontSize: AppStyles.subtitleFontSize,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Image.asset(
                                    AppAssets.idCardIcon,
                                    height: 20,
                                    width: 20,
                                  ),
                                ),
                                Text(
                                  "${_producerController.selectedProducer.cpfCnpj}",
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 4.0),
                                  child: _producerController
                                              .selectedProducer.gender ==
                                          "M"
                                      ? const Icon(
                                          Icons.male,
                                          color: Colors.blue,
                                        )
                                      : const Icon(
                                          Icons.female,
                                          color: Colors.pink,
                                        ),
                                ),
                                Text(_producerController
                                            .selectedProducer.gender ==
                                        "M"
                                    ? "Masculino"
                                    : "Feminino")
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Image.asset(
                                    AppAssets.typeIcon,
                                    height: 20,
                                    width: 20,
                                  ),
                                ),
                                Text(
                                  "${_producerController.selectedProducer.isCnpj == 0 ? "Pessoa Fisica" : "Pessoa Jurídica"} ",
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => CustomModalBottomSheet.show(
                          context,
                          items: [
                            CustomButton(
                              icon: Icons.edit,
                              titleBtn: 'Editar produtor',
                              btnColor: _colorScheme.tertiary,
                              function: () {
                                Navigator.pop(context);
                                showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (context) => CreateProducerDialog(
                                    producer:
                                        _producerController.selectedProducer,
                                  ),
                                );
                              },
                            ),
                            CustomButton(
                              icon: Icons.delete,
                              titleBtn: 'Excluir produtor',
                              btnColor: Colors.red,
                              function: () {
                                Navigator.pop(context);
                                showDialog(
                                  context: context,
                                  builder: (context) => CustomDialogBox(
                                    title: "Excluir produtor",
                                    descriptions:
                                        'Tem certeza que deseja excluir este produtor?',
                                    isDanger: true,
                                    confirmText: 'Excluir',
                                    confirmFunction: () async {
                                      await _producerController
                                          .deleteProducerDb(
                                        _producerController
                                            .selectedProducer.id!,
                                      );
                                    },
                                  ),
                                );
                              },
                            )
                          ],
                        ),
                        icon: Icon(
                          Icons.edit,
                          color: _colorScheme.secondary,
                        ),
                      ),
                    ],
                  ),
                ),

                // FARM CARDs
                Container(
                  height: 200,
                  padding: const EdgeInsets.all(16),
                  decoration:
                      BoxDecoration(color: _colorScheme.primaryContainer),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Fazendas",
                              style: TextStyle(
                                color: _colorScheme.onPrimaryContainer,
                                fontSize: AppStyles.subtitleFontSize,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: InkWell(
                                onTap: () async {
                                  var result = await showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (context) => CreateFarmDialog(),
                                  );
                                  if (result != null) {
                                    _producerController
                                        .selectedProducer.listFarm!
                                        .add(result);
                                  }
                                },
                                child: CircleAvatar(
                                  radius: 15,
                                  backgroundColor:
                                      _colorScheme.onPrimaryContainer,
                                  child: Icon(
                                    Icons.add,
                                    color: _colorScheme.primaryContainer,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      _producerController.selectedProducer.listFarm!.isNotEmpty
                          ? Flexible(
                              child: Center(
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) => _FarmCard(
                                    colorScheme: _colorScheme,
                                    farm: _producerController
                                        .selectedProducer.listFarm![index],
                                    controller: _producerController,
                                  ),
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                    width: 16,
                                  ),
                                  itemCount: _producerController
                                      .selectedProducer.listFarm!.length,
                                ),
                              ),
                            )
                          : Expanded(
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.landscape_outlined,
                                      color: _colorScheme.onPrimaryContainer,
                                    ),
                                    Text(
                                      "Nenhuma fazenda registrada.",
                                      style: TextStyle(
                                        color: _colorScheme.onPrimaryContainer,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                    ],
                  ),
                ),

                // FARMS INFO
                Visibility(
                  visible:
                      _producerController.selectedProducer.listFarm!.isNotEmpty,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text.rich(
                                TextSpan(
                                  style: const TextStyle(
                                      fontSize: AppStyles.bodyFontSize),
                                  children: [
                                    const TextSpan(
                                      text: "Nome: ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          "${_producerController.selectedFarm.name}",
                                    ),
                                  ],
                                ),
                              ),
                              Text.rich(
                                TextSpan(
                                  style: const TextStyle(
                                      fontSize: AppStyles.bodyFontSize),
                                  children: [
                                    const TextSpan(
                                      text: "Estado: ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          "${_producerController.selectedFarm.state}",
                                    ),
                                  ],
                                ),
                              ),
                              Text.rich(
                                TextSpan(
                                  style: const TextStyle(
                                      fontSize: AppStyles.bodyFontSize),
                                  children: [
                                    const TextSpan(
                                      text: "Cidade: ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          "${_producerController.selectedFarm.city}",
                                    ),
                                  ],
                                ),
                              ),
                              Text.rich(
                                TextSpan(
                                  style: const TextStyle(
                                      fontSize: AppStyles.bodyFontSize),
                                  children: [
                                    const TextSpan(
                                      text: "Hectares: ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          "${_producerController.selectedFarm.hectares}",
                                    ),
                                  ],
                                ),
                              ),
                              Visibility(
                                visible: _producerController
                                            .selectedFarm.location !=
                                        null &&
                                    _producerController.selectedFarm.location !=
                                        "",
                                child: Text.rich(
                                  TextSpan(
                                    style: const TextStyle(
                                        fontSize: AppStyles.bodyFontSize),
                                    children: [
                                      const TextSpan(
                                        text: "Logradouro: ",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(
                                          text:
                                              "${_producerController.selectedFarm.location}"),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () => CustomModalBottomSheet.show(
                            context,
                            items: [
                              CustomButton(
                                  icon: Icons.edit,
                                  titleBtn: 'Editar fazenda',
                                  btnColor: _colorScheme.tertiary,
                                  function: () {
                                    Navigator.pop(context);
                                    showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (context) => CreateFarmDialog(
                                        farm: _producerController.selectedFarm,
                                      ),
                                    );
                                  }),
                              CustomButton(
                                icon: Icons.delete,
                                titleBtn: 'Excluir fazenda',
                                btnColor: Colors.red,
                                function: () {
                                  Navigator.pop(context);
                                  showDialog(
                                    context: context,
                                    builder: (context) => CustomDialogBox(
                                      title: "Excluir fazenda",
                                      descriptions:
                                          'Tem certeza que deseja excluir esta fazenda?',
                                      isDanger: true,
                                      confirmText: 'Excluir',
                                      confirmFunction: () async {
                                        await _producerController.deleteFarmDb(
                                          _producerController.selectedFarm.id!,
                                        );
                                      },
                                    ),
                                  );
                                },
                              )
                            ],
                          ),
                          icon: Icon(
                            Icons.edit,
                            color: _colorScheme.secondary,
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                // FIELD CARDs
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                "Talhões/Campos",
                                style: TextStyle(
                                  color: _colorScheme.primary,
                                  fontSize: AppStyles.subtitleFontSize,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: GestureDetector(
                                onTap: () => showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (context) => CreateFieldDialog(),
                                ),
                                child: CircleAvatar(
                                  maxRadius: 15,
                                  backgroundColor: _colorScheme.primary,
                                  child: Icon(
                                    Icons.add,
                                    color: _colorScheme.onPrimary,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () =>
                                  _producerController.showSearch(context),
                              child: CircleAvatar(
                                maxRadius: 20,
                                backgroundColor:
                                    _producerController.visibleSearch.value
                                        ? _colorScheme.tertiary
                                        : _colorScheme.secondary,
                                child: Icon(
                                  _producerController.visibleSearch.value
                                      ? Icons.cancel
                                      : Icons.search,
                                  color: _colorScheme.onSecondary,
                                  size: 20,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),

                      // SEARCH BOX
                      Visibility(
                        visible: _producerController.visibleSearch.value,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: TextField(
                            controller:
                                _producerController.searchFieldController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Theme.of(context).cardColor,
                              hintText: "Procurar talhão",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                              isDense: true,
                              prefixIcon: const Icon(
                                Icons.search,
                                size: 26,
                              ),
                              suffixIcon: _producerController
                                          .searchFieldController.value.text !=
                                      ""
                                  ? IconButton(
                                      icon: const Icon(Icons.cancel),
                                      onPressed: _producerController
                                          .clearSearchBoxField,
                                    )
                                  : null,
                            ),
                            onChanged: (String? text) {
                              if (text != null) {
                                _producerController.searchField.value = text;
                              }
                            },
                          ),
                        ),
                      ),
                      if (_producerController.fieldList.isNotEmpty)
                        SizedBox(
                          child: Column(
                            children: [
                              for (FieldModel field
                                  in _producerController.fieldList)
                                _FieldCard(
                                  colorScheme: _colorScheme,
                                  field: field,
                                  controller: _producerController,
                                )
                            ],
                          ),
                        )
                      else
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.landscape_outlined,
                              ),
                              Text(
                                "Nenhum talhão registrado.",
                              ),
                            ],
                          ),
                        ),
                    ],
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

class _FieldCard extends StatelessWidget {
  const _FieldCard({
    Key? key,
    required ColorScheme colorScheme,
    required ProducerController controller,
    required this.field,
  })  : _colorScheme = colorScheme,
        _controller = controller,
        super(key: key);

  final ColorScheme _colorScheme;
  final FieldModel field;
  final ProducerController _controller;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _controller.onFiedlSelect(field),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(
                  Icons.area_chart_outlined,
                  color: _colorScheme.primary,
                  size: 32,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(field.name!),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text.rich(
                          TextSpan(
                            style: const TextStyle(
                                fontSize: AppStyles.bodyFontSize),
                            children: [
                              TextSpan(
                                text: "Cultura: ",
                                style: TextStyle(
                                  color: _colorScheme.secondary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: "${field.culture!.name}",
                              ),
                            ],
                          ),
                        ),
                        Text.rich(
                          TextSpan(
                            style: const TextStyle(
                                fontSize: AppStyles.bodyFontSize),
                            children: [
                              TextSpan(
                                text: "Area: ",
                                style: TextStyle(
                                  color: _colorScheme.secondary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: "${field.hectare} ha",
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FarmCard extends StatelessWidget {
  const _FarmCard({
    Key? key,
    required ColorScheme colorScheme,
    required FarmModel farm,
    required ProducerController controller,
  })  : _colorScheme = colorScheme,
        _farm = farm,
        _controller = controller,
        super(key: key);

  final ColorScheme _colorScheme;
  final FarmModel _farm;
  final ProducerController _controller;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProducerController>(
      init: _controller,
      builder: (_) {
        return GestureDetector(
          onTap: () => _controller.onFarmSelect(_farm),
          child: AspectRatio(
            aspectRatio: _controller.selectedFarm.id == _farm.id ? 1 : 0.9,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 30,
              margin: const EdgeInsets.all(4),
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage(
                    AppAssets.fieldIcon,
                  ),
                  fit: BoxFit.cover,
                ),
                color: _colorScheme.secondaryContainer,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  _controller.selectedFarm.id == _farm.id
                      ? BoxShadow(
                          color: _colorScheme.background,
                          spreadRadius: 3,
                        )
                      : const BoxShadow(),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Expanded(child: SizedBox()),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: _colorScheme.background.withOpacity(0.7),
                      borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(15),
                      ),
                    ),
                    child: Text(
                      "${_farm.name}",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
