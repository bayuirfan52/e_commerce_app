import 'package:e_commerce_app/app/modules/product/product_repository.dart';
import 'package:get/get.dart';

import 'product_controller.dart';

class ProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ProductRepository>(ProductRepository());
    Get.lazyPut(() => ProductController());
  }
}
