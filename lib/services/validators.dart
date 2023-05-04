import 'package:get/get.dart';

class Validators {
  static String? passwordValidator(String? password) {
    if (password == null || password.isEmpty) {
      return 'Digite sua senha';
    }
    if (password.length < 6) {
      return 'Digite uma senha com pelo menos 6 caracteres';
    }
    return null;
  }

  static String? nameValidator(String? name) {
    if (name == null || name.isEmpty) {
      return 'Digite um nome!';
    }

    if (name.length < 2) return 'Digite um nome válido!';

    return null;
  }

  static String? phoneValidator(String? phone) {
    if (phone == null || phone.isEmpty) {
      return 'Digite um telefone!';
    }
    if (phone.length < 14 || !phone.isPhoneNumber) {
      return 'Digite um número válido!';
    }

    return null;
  }

  static String? cpfValidator(String? cpf) {
    if (cpf == null || cpf.isEmpty) {
      return 'Digite um CPF!';
    }
    if (!cpf.isCpf) return 'Digite um cpf válido!';

    return null;
  }

  static String? dateValidator(String? dateStr) {
    if (dateStr != null && dateStr.isNotEmpty) {
      RegExp dateRegex = RegExp(r'^\d{2}-\d{2}-\d{4}$');
      if (!dateRegex.hasMatch(dateStr)) {
        // A string não está no formato correto
        return 'Data inválida';
      }
      int day = int.parse(dateStr.substring(0, 2));
      int month = int.parse(dateStr.substring(3, 5));
      int year = int.parse(dateStr.substring(6));
      if (month < 1 || month > 12) {
        // O mês é inválido
        return 'Mês inválido';
      }
      int maxDay = DateTime(year, month + 1, 0).day;
      if (day < 1 || day > maxDay) {
        // O dia é inválido
        return "Dia inválido";
      }
      return null;
    }
    return "Data obrigatória";
  }
}
