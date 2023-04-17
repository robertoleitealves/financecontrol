import 'package:financecontrol/pages/creditcard/creditcard_controller.dart';
import 'package:get/get.dart';

class CreditCardBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(CreditCardController());
  }
}
