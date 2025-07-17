import 'package:collarchek/portfolio/portfolio_controllers.dart';
import 'package:get/get.dart';

class PortfolioBindings extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(PortfolioControllers());
  }

}