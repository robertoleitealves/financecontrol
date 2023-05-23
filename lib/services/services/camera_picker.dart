import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:izconsultores/src/services/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';

abstract class TakeCameraPicker {
  static Future takePicture(BuildContext context) async {
    AssetEntity? entity;

    final CameraPickerConfig _cameraPickerConfig = CameraPickerConfig(
      textDelegate: PortugueseCameraPickerTextDelegate(),
      enableRecording: false,
      onlyEnableRecording: false,
    );

    PermissionStatus status = await Permission.camera.status;
    if (status == PermissionStatus.granted ||
        status == PermissionStatus.limited) {
      entity = await CameraPicker.pickFromCamera(
        context,
        pickerConfig: _cameraPickerConfig,
      );

      if (entity != null) {
        String? title = entity.title;
        String? tempPath = (await getApplicationDocumentsDirectory()).path;
        var bytes = await entity.originBytes;

        File file = File('$tempPath/$title');
        File returnFile = await file.writeAsBytes(bytes!.buffer
            .asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));
        return returnFile;
      } else {
        return null;
      }
    } else {
      var status = await Permission.camera.request();
      if (status == PermissionStatus.granted ||
          status == PermissionStatus.limited) {
        takePicture(context);
      } else {
        UtilsServices().showToast(message: "Permissão de câmera negada");
        openAppSettings();
      }
    }
  }
}

class PortugueseCameraPickerTextDelegate implements CameraPickerTextDelegate {
  factory PortugueseCameraPickerTextDelegate() => _instance;

  PortugueseCameraPickerTextDelegate._internal();

  static final PortugueseCameraPickerTextDelegate _instance =
      PortugueseCameraPickerTextDelegate._internal();

  @override
  String get languageCode => 'pt-Br';

  @override
  String get confirm => 'Confirmar';

  @override
  String get shootingTips => 'Toque para tirar uma foto.';

  @override
  String get shootingWithRecordingTips =>
      'Toque para tirar uma foto. Pressione e segure para gravar vídeo.';

  @override
  String get shootingOnlyRecordingTips =>
      'Pressione e segure para gravar vídeo.';

  @override
  String get shootingTapRecordingTips => 'Toque para gravar vídeo.';

  @override
  String get loadFailed => 'Erro de carregamento';

  @override
  String get loading => 'Carregando...';

  @override
  String get saving => 'Salvando...';

  @override
  String get sActionManuallyFocusHint => 'foco manualmente';

  @override
  String get sActionPreviewHint => 'Visualizar';

  @override
  String get sActionRecordHint => 'Registro';

  @override
  String get sActionShootHint => 'Tirar foto';

  @override
  String get sActionShootingButtonTooltip => 'botão de tiro';

  @override
  String get sActionStopRecordingHint => 'Parar de gravar';

  @override
  String sCameraLensDirectionLabel(CameraLensDirection value) => value.name;

  @override
  String? sCameraPreviewLabel(CameraLensDirection? value) {
    if (value == null) {
      return null;
    }
    return '${sCameraLensDirectionLabel(value)} visualização da câmera';
  }

  @override
  String sFlashModeLabel(FlashMode mode) => 'Modo de flash: ${mode.name}';

  @override
  String sSwitchCameraLensDirectionLabel(CameraLensDirection value) =>
      'Switch to the ${sCameraLensDirectionLabel(value)} camera';
}
