import 'package:e_commerce_app/app/modules/cart/cart_repository.dart';
import 'package:get/get.dart';

import 'cart_controller.dart';

class CartBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CartRepository());
    Get.lazyPut<CartController>(() => CartController());
  }
}
