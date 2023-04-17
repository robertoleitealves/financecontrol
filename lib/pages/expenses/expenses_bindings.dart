import 'package:financecontrol/pages/expenses/expenses_controller.dart';
import 'package:get/get.dart';

class ExpensesBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(ExpensesController());
  }
}
