
import 'package:get/get.dart';

import '../controller/expenses_controller.dart';

class ExpensesBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(ExpensesController());
  }
}
