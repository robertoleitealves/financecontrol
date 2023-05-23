import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class UtilsServices {
  final storage = const FlutterSecureStorage();
  // Salva dado localmente em segurança
  Future<void> saveLocalData(
      {required String key, required String data}) async {
    await storage.write(key: key, value: data);
  }

  // Recupera dado salvo localmente em segurança
  Future<String?> getLocalData({required String key}) async {
    return await storage.read(key: key);
  }

  // Remove dado salvo localmente
  Future<void> removeLocalData({required String key}) async {
    await storage.delete(key: key);
  }

  String priceToCurrency(double price) {
    NumberFormat numberFormat = NumberFormat.simpleCurrency(locale: 'pt-BR');
    return numberFormat.format(price);
  }

  String formatDateTime(DateTime dateTime) {
    initializeDateFormatting();

    DateFormat dateFormat = DateFormat.yMd('pt_BR').add_Hm();
    return dateFormat.format(dateTime);
  }

  DateTime convertToDateTime(String date) {
    final dateFormat = DateFormat('dd-MM-yyyy');
    final auxDate = dateFormat.parse(date);
    final outputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");
    final output = outputFormat.format(auxDate);
    return DateTime.parse(output);
  }

  void showToast(
      {required String message, bool isError = false, isSuccess = false}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      textColor: isError || isSuccess ? Colors.white : Colors.black,
      backgroundColor: isError
          ? Colors.red
          : isSuccess
              ? Colors.green
              : Colors.white,
      fontSize: 14,
    );
  }

  Future<void> appLaunchUrl(String url) async {
    Uri uri = Uri.parse(url);
    try {
      await launchUrl(uri);
    } catch (error) {
      showToast(message: "Não foi possível abrir o site", isError: true);
      throw 'Não foi possível abrir o site $url';
    }
  }

  Future<String> appVersionInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String versionNumber = packageInfo.version + '+' + packageInfo.buildNumber;
    return versionNumber;
  }

  Future<Position> getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Os serviços de localização estão desativados.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Permissões de localização negadas');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  // VERIFICA QUAL SO O USUÁRIO ESTÁ USANDO
  int verifyPlatform() {
    String platform = Platform.operatingSystem;
    switch (platform) {
      case "android":
        return 1;
      case "ios":
        return 2;
      case "windows":
        return 3;
      case "macos":
        return 4;
      case "linux":
        return 5;
      case "fuchsia":
        return 6;
      default:
        return 1;
    }
  }
}
