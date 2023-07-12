import 'package:e_commerce_app/app/core/base/base_controller.dart';
import 'package:e_commerce_app/app/helper/ex_log.dart';
import 'package:e_commerce_app/app/helper/flushbar_helper.dart';
import 'package:e_commerce_app/app/helper/loading_helper.dart';
import 'package:e_commerce_app/app/model/products_entity.dart';
import 'package:e_commerce_app/app/modules/product/product_repository.dart';
import 'package:e_commerce_app/app/routes/app_pages.dart';
import 'package:get/get.dart';

class ProductController extends BaseController<ProductRepository> with StateMixin<ProductsEntity> {
  final id = ''.obs;
  final cart = <ProductsEntity>[].obs;
  final isProductOnCart = false.obs;

  @override
  void onInit() {
    super.onInit();
    id.value = Get.arguments as String;
  }

  @override
  void onReady() {
    super.onReady();
    _getDetailProduct(id.value).then((value) => _getCart().then((value) => checkProductIsAddedToCart()));
  }

  void checkProductIsAddedToCart() {
    var isAdded = false;
    cart.forEach((element) {
      isAdded = element.id == state?.id;
    });
    isProductOnCart.value = isAdded;
  }

  void goToCart() => Get.toNamed<dynamic>(Routes.CART);

  void goToCheckout() {
    final listProduct = <ProductsEntity>[];
    if (state != null) {
      listProduct.add(state!);
    }

    Get.toNamed<dynamic>(Routes.CHECKOUT, arguments: listProduct);
  }

  void addToCart() {
    if (state != null) {
      repo.addProductToCart(state!);
    }
    _getCart().then((value) => checkProductIsAddedToCart());
    FlushbarHelper.showFlushbar(Get.context!, FlushbarType.SUCCESS, message: 'Product Added Successfully!');
  }

  Future<void> _getCart() async {
    cart.value = await repo.getCartData();
    logI(cart.toString());
  }

  Future<void> _getDetailProduct(String id) async {
    LoadingHelper.show();
    change(null, status: RxStatus.loading());
    await repo.getProduct(id).then((value) {
      LoadingHelper.dismiss();
      final response = ProductsEntity.fromJson(value.body as Map<String, dynamic>);
      change(response, status: RxStatus.success());
    }).catchError((dynamic error) {
      LoadingHelper.dismiss();
      change(null, status: RxStatus.error('$error'));
    });
  }
}
