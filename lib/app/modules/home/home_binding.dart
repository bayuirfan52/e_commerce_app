import 'package:e_commerce_app/app/modules/home/home_repository.dart';
import 'package:get/get.dart';

import 'home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<HomeRepository>(HomeRepository());
    Get.put<HomeController>(HomeController());
  }
}
