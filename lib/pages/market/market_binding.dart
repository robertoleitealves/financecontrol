import 'package:financecontrol/pages/market/market_controller.dart';
import 'package:get/get.dart';

class MarketBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(MarketController());
  }
}
