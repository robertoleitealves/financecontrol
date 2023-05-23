import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

abstract class MaskFormatter {
  static final cepMask = MaskTextInputFormatter(
      mask: '#####-###', filter: {"#": RegExp(r'[0-9]')});

  static final phoneMask = MaskTextInputFormatter(
      mask: '(##)#####-####', filter: {"#": RegExp(r'[0-9]')});

  static final cpfMask = MaskTextInputFormatter(
      mask: '###.###.###-##', filter: {"#": RegExp(r'[0-9]')});

  static final cnpjMask = MaskTextInputFormatter(
    mask: '##.###.###/####-##',
    filter: {"#": RegExp(r'[0-9]')},
  );

  static final dateMask = MaskTextInputFormatter(
      mask: '##-##-####', filter: {"#": RegExp(r'[0-9]')});

  static final rgMask = MaskTextInputFormatter(mask: '########-#');
}
