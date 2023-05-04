import 'package:intl/intl.dart';

extension FormatterExtension on double {
  String get currencyPTBR {
    final currencyFormat =
        NumberFormat.currency(locale: 'pt-BR', symbol: r'R$');
    return currencyFormat.format(this);
  }
}

extension FormatterStringExtension on String {
  String get toShortDate {
    final date = DateFormat("dd-MM-yyyy").format(DateTime.parse(this));
    return date;
  }

  String get toShortDateWithTime {
    final date =
        DateFormat("hh:mm:ss  dd/MM/yyyy").format(DateTime.parse(this));
    return date;
  }

  String get toDateTime {
    final originalFormat = DateFormat('dd-MM-yyyy');
    final date = originalFormat.parse(this);
    final newFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");
    return newFormat.format(date);
  }
}
