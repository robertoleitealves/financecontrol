// INSIDE
import 'package:flutter/material.dart';

Map<int, Color> _swatchOpacity = {
  50: const Color.fromRGBO(12, 110, 69, 0.1),
  100: const Color.fromRGBO(12, 110, 69, 0.2),
  200: const Color.fromRGBO(12, 110, 69, 0.3),
  300: const Color.fromRGBO(12, 110, 69, 0.4),
  400: const Color.fromRGBO(12, 110, 69, 0.5),
  500: const Color.fromRGBO(12, 110, 69, 0.6),
  600: const Color.fromRGBO(12, 110, 69, 0.7),
  700: const Color.fromRGBO(12, 110, 69, 0.8),
  800: const Color.fromRGBO(12, 110, 69, 0.9),
  900: const Color.fromRGBO(12, 110, 69, 1),
};

abstract class CustomColors {
  static const Color customContrastColor = Color.fromRGBO(238, 125, 0, 1);

  static MaterialColor customSwatchColor =
      MaterialColor(0xFF0c6e45, _swatchOpacity);
}

abstract class AppColors {
  // Background Colors
  static const Color primary = Color(0xFF0c6e45);
  static const Color primaryLight = Color(0xFF479d70);
  static const Color primaryDark = Color(0xFF00421d);
  static const Color secondary = Color(0xFFee7d00);
  static const Color secondaryLight = Color(0xFFffad42);
  static const Color secondaryDark = Color(0xFFb54f00);
  static const Color grey = Color(0xFF808080);
  static const Color danger = Color(0xFFff0000);
  static const Color background = Color(0xFFFFFFFF);

  // TEXT COLORS
  static const Color textColorPrimary = Color(0xFFFFFFFF);
  static const Color textColorSecondary = Color(0xFF000000);
}

class AppStyles {
  // FontSize
  static const titleFontSize = 18.0;
  static const subtitleFontSize = 16.0;
  static const bodyFontSize = 14.0;
  static const smallBodyFontSize = 12.0;

  static const appFont1 = 'Roboto';
  static const appFont2 = 'BebasNeue';

  static const padding = 8.0;
  static const borderradius = 15.0;
}

class AppAssets {
  static const appLogo = 'assets/app_logo.png';
  static const limingIcon = 'assets/images/liming.jpg';
  static const fertigranIcon = 'assets/images/fertigran.jpg';
  static const mipIcon = 'assets/images/scouting.jpg';
  static const advReportIcon = 'assets/images/avancado.jpg';
  static const questionsIcon = 'assets/images/circle-questions.png';
  static const prescriptionIcon = 'assets/images/prescription.jpg';
  static const reportIcon = 'assets/images/report.jpg';
  static const producerIcon = 'assets/images/producer.png';
  static const fieldIcon = 'assets/images/field.jpg';
  static const banner = 'assets/images/banner.png';
  static const whatsappIcon = 'assets/icons/whatsappIcon.png';
  static const gmailIcon = 'assets/icons/gmailIcon.png';
  static const idCardIcon = 'assets/icons/id_card.png';
  static const plantIcon = 'assets/icons/plantIcon.png';
  static const fruitVector = 'assets/icons/fruitVector.png';
  static const figmaIcon = 'assets/icons/figmaIcon.png';
  static const vectorPlant = 'assets/icons/vector.png';
  static const bugIcon = 'assets/icons/bugIcon.png';
  static const typeIcon = 'assets/icons/typeIcon.png';
  static const vectorField = 'assets/icons/vectorfield.png';
  static const consultantIcon = 'assets/images/consultor.png';
  static const producer = 'assets/images/produtor.jpeg';
}

class AppLinks {
  static const whatsappUrl =
      "whatsapp://send?phone=+5516999860503&text=Olá, vim do FAQ do IZConsultores e gostaria de tirar uma dúvida.";
}
