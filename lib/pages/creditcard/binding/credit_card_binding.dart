import 'package:financecontrol/pages/creditcard/controller/creditcard_controller.dart';
import 'package:get/get.dart';

class CreditCardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => CreditCardController(),
    );
  }
}
