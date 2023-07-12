import 'package:e_commerce_app/app/core/base/base_controller.dart';
import 'package:e_commerce_app/app/helper/ex_log.dart';
import 'package:e_commerce_app/app/model/products_entity.dart';
import 'package:e_commerce_app/app/modules/home/home_repository.dart';
import 'package:e_commerce_app/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeController extends BaseController<HomeRepository> {
  final category = <String>[].obs;
  final products = <ProductsEntity>[].obs;
  final allProducts = <ProductsEntity>[].obs;
  final cart = <ProductsEntity>[].obs;
  final selectedCategory = ''.obs;
  final searchController = TextEditingController();
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    getProducts();
    _getCart();
  }

  void goToDetailProduct(String id) => Get.toNamed<dynamic>(Routes.PRODUCT, arguments: id)?.then((value) => _getCart());
  void goToNotification() => Get.toNamed<dynamic>(Routes.NOTIFICATION);
  void goToCart() => Get.toNamed<dynamic>(Routes.CART)?.then((value) => _getCart());

  void filterData(int index) {
    products.clear();
    selectedCategory.value = category[index];
    if (index == 0) {
      products.addAll(allProducts);
    } else {
      products.value = allProducts.filter((element) => selectedCategory.value == element.category).toList();
    }
    update();
  }

  void searchData(String text) {
    products.clear();
    if (text.isEmptyOrNull) {
      products.addAll(allProducts);
    } else {
      products.value = allProducts.filter((element) => element.title?.toLowerCase().contains(text) ?? true).toList();
      update();
    }
  }

  Future<void> getProducts() async {
    products.clear();
    allProducts.clear();
    category.clear();
    category.add('All');
    isLoading.value = true;
    await repo.getProducts().then((value) {
      isLoading.value = false;
      final response = value.body as List<dynamic>;

      response.forEach((element) {
        final item = ProductsEntity.fromJson(element as Map<String, dynamic>);
        products.add(item);
        if (!category.contains(item.category)) {
          category.add(item.category ?? '');
        }
      });
      allProducts.addAll(products);
      selectedCategory.value = category[0];
    }).catchError((dynamic error) {
      isLoading.value = false;
      logE(error);
    });
  }

  Future<void> _getCart() async {
    cart.value = await repo.getCartData();
  }
}
