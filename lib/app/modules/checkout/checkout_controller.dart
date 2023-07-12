import 'package:e_commerce_app/app/model/products_entity.dart';
import 'package:get/get.dart';

class CheckoutController extends GetxController {
  final listCart = <ProductsEntity>[].obs;
  final totalPayment = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    listCart.value = Get.arguments as List<ProductsEntity>;
  }

  @override
  void onReady() {
    super.onReady();
    listCart.forEach((element) {
      totalPayment.value += element.price ?? 0.0;
    });
  }
}
