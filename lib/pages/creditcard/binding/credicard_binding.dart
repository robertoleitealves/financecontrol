
import 'package:get/get.dart';

import '../controller/creditcard_controller.dart';

class CreditCardBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(CreditCardController());
  }
}
