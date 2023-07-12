import 'package:e_commerce_app/app/core/base/base_controller.dart';
import 'package:e_commerce_app/app/model/products_entity.dart';
import 'package:e_commerce_app/app/modules/cart/cart_repository.dart';
import 'package:e_commerce_app/app/routes/app_pages.dart';
import 'package:get/get.dart';

class CartController extends BaseController<CartRepository> {
  final listCart = <ProductsEntity>[].obs;
  final totalPayment = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    _getCart();
  }

  void checkout() => Get.toNamed<dynamic>(Routes.CHECKOUT, arguments: listCart);

  Future<void> _getCart() async {
    listCart.value = await repo.getCartData();
    listCart.forEach((element) {
      totalPayment.value += element.price ?? 0.0;
    });
  }

  Future<void> removeProduct(int index) async {
    await repo.removeProduct(listCart[index]);
    await _getCart();
  }
}
