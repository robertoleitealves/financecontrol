import 'package:get/get.dart';
import '../controller/expenses_controller.dart';

class ExpenseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => ExpensesController(),
    );
  }
}
