// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:izconsultores/src/constants/constants.dart';

import 'package:izconsultores/src/models/field_model.dart';
import 'package:izconsultores/src/models/fieldmap_model.dart';
import 'package:izconsultores/src/pages/common_widget/custom_app_bar.dart';
import 'package:izconsultores/src/pages/common_widget/google_maps/coordinates_map.dart';
import 'package:izconsultores/src/pages/common_widget/google_maps/custom_google_map.dart';
import 'package:izconsultores/src/pages/common_widget/google_maps/edit_google_map_screen.dart';
import 'package:izconsultores/src/pages/producers/components/create_field_dialog.dart';
import 'package:izconsultores/src/pages/producers/controller/producer_controller.dart';

class FieldScreen extends StatefulWidget {
  final FieldModel field;

  const FieldScreen({required this.field, Key? key}) : super(key: key);

  @override
  State<FieldScreen> createState() => _FieldScreenState();
}

class _FieldScreenState extends State<FieldScreen> {
  final DateFormat dateFormat = DateFormat('dd-MM-yyyy');
  final _controller = Get.find<ProducerController>();
  List<FieldMapModel> _fieldMapList = [];
  CoordinatesMap coordinatesMap = CoordinatesMap();

  @override
  void initState() {
    super.initState();
    _loadFields();
  }

  void _loadFields() async {
    //_fieldMapList.addAll(widget.field.fieldMap ?? []);
    _controller.isLoading.value = true;
    if (_fieldMapList.isEmpty) {
      _fieldMapList = await _controller.getFieldMapByField(widget.field.id!);
      setState(() {});
    }
    _controller.isLoading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    var _soilTtype =
        soilTypes.where((type) => type['id'] == widget.field.soilTypeId!).first;
    return Scaffold(
      appBar: CustomAppBar(
        title: const Text("Visualizar talhão"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              shadowColor: Colors.grey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        Text(
                          '${widget.field.name!} ',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            onPressed: () => showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) => CreateFieldDialog(
                                field: widget.field,
                              ),
                            ),
                            icon: Icon(
                              Icons.edit,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      color: Colors.grey,
                      indent: 16,
                      endIndent: 16,
                    ),
                    _CustomTextRich(
                        title: "Hectares: ", value: "${widget.field.hectare}"),
                    _CustomTextRich(
                        title: "Latitude: ", value: "${widget.field.latitude}"),
                    _CustomTextRich(
                        title: "Longitude: ",
                        value: "${widget.field.longitude}"),
                  ],
                ),
              ),
            ),
            Card(
              shadowColor: Colors.grey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const Text(
                      "Cultura",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Divider(
                      color: Colors.grey,
                      indent: 16,
                      endIndent: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        "${widget.field.culture!.name}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              shadowColor: Colors.grey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const Text(
                      "Tipo do Solo",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Divider(
                      color: Colors.grey,
                      indent: 16,
                      endIndent: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        _soilTtype['type'] as String,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              shadowColor: Colors.grey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const Text(
                      "Data de plantio/Poda",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Divider(
                      color: Colors.grey,
                      indent: 16,
                      endIndent: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        dateFormat
                            .format(DateTime.parse(widget.field.planningDate!)),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: _controller.hasInternet(),
              child: _fieldMapList.isNotEmpty
                  ? CustomGoogleMap(
                      coordinatesMap: coordinatesMap,
                      fieldMapList: _fieldMapList,
                    )
                  : _controller.isLoading.value
                      ? const AspectRatio(
                          aspectRatio: 4 / 3,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : AspectRatio(
                          aspectRatio: 4 / 3,
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text('Não há dados para mostrar'),
                                TextButton.icon(
                                  onPressed: () {
                                    Get.to(() => const EditGoogleMapScreen());
                                  },
                                  icon:
                                      const Icon(Icons.edit_location_outlined),
                                  label: const Text(
                                    "Desenhar mapa do talhão",
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
              replacement: AspectRatio(
                aspectRatio: 4 / 3,
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(4),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(15)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.signal_wifi_connected_no_internet_4_outlined),
                      Text(
                        "Sem conexão com a internet para visualizar desenho do talhão",
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _CustomTextRich extends StatelessWidget {
  final String title;
  final String value;
  const _CustomTextRich({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        style: const TextStyle(fontSize: 18),
        children: [
          TextSpan(
            text: title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: value,
          ),
        ],
      ),
    );
  }
}
