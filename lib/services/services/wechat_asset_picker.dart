import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

abstract class TakePictureFromGallery {


  static Future takePicture(
    BuildContext context, {
    int maxAssets = 1,
    RequestType requestType = RequestType.image,
  }) async {

    final List<AssetEntity> _listAssets = [];
    
    final AssetPickerConfig _assetPickerConfig = AssetPickerConfig(
      textDelegate: PortugueseTextDelegate(),
      selectedAssets: _listAssets,
      maxAssets: maxAssets,
      requestType: requestType,
      specialPickerType: maxAssets == 1 ? SpecialPickerType.noPreview : null,
    );

     final List<AssetEntity>? assets = await AssetPicker.pickAssets(
      context,
      pickerConfig: _assetPickerConfig,
    );

    if (assets != null) {
      if (maxAssets == 1) {
        var image = assets.first;
        String fileName = image.title!;
        String tempPath = (await getApplicationDocumentsDirectory()).path;

        Uint8List? bytes = await image.originBytes;

        File file = File("$tempPath/$fileName");

        File returnFile = await file.writeAsBytes(bytes!.buffer
            .asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));

        return returnFile;
      } else {
        List<File> _listFile = [];
        for (AssetEntity asset in assets) {
          var image = asset;
          String fileName = image.title!;
          String tempPath = (await getApplicationDocumentsDirectory()).path;

          Uint8List? bytes = await image.originBytes;

          File file = File("$tempPath/$fileName");

          File returnFile = await file.writeAsBytes(bytes!.buffer
              .asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));

          _listFile.add(returnFile);
        }

        return _listFile;
      }
    }
  }
}

class PortugueseTextDelegate extends AssetPickerTextDelegate {
  factory PortugueseTextDelegate() => _instance;

  PortugueseTextDelegate._internal();

  static final PortugueseTextDelegate _instance =
      PortugueseTextDelegate._internal();

  @override
  String confirm = 'Confirmar';

  @override
  String cancel = 'Cancelar';

  @override
  String edit = 'Editar';

  @override
  String gifIndicator = 'GIF';

  @override
  String loadFailed = 'Falha no Carregamento';

  @override
  String original = 'Original';

  @override
  String preview = 'Pré-Visualização';

  @override
  String select = 'Selecionar';

  @override
  String unSupportedAssetType = 'Formato não suportado';

  @override
  String unableToAccessAll =
      'Não foi possível acessar a mídia de armazenamento';

  @override
  String viewingLimitedAssetsTip =
      'Ver apenas ativos e álbuns acessíveis ao aplicativo.';

  @override
  String changeAccessibleLimitedAssets =
      'Atualizar lista de ativos de acesso limitado ';

  @override
  String accessAllTip =
      'O aplicativo só pode acessar alguns ativos do dispositivo. '
      'Vá para as configurações do sistema e permita que o aplicativo acesse todos os ativos do dispositivo.';

  @override
  String goToSystemSettings = 'Vá para as configurações do sistema';

  @override
  String accessLimitedAssets = 'Continue com acesso limitado';

  @override
  String accessiblePathName = 'Ativos acessíveis';
}
