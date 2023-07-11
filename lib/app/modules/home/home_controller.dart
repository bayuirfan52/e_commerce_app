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
  }

  void goToDetailProduct(String id) => Get.toNamed<dynamic>(Routes.PRODUCT, arguments: id);
  void goToNotification() => Get.toNamed<dynamic>(Routes.NOTIFICATION);
  void goToCart() => Get.toNamed<dynamic>(Routes.CART);

  void filterData(int? index) {
    products.clear();
    if (index == null) {
      products.value = allProducts;
    } else {
      selectedCategory.value = category[index];
      final data = allProducts;
      products.value = data.filter((element) => selectedCategory.value == element.category).toList();
    }
  }

  void searchData(String text) {
    products.clear();
    if (text.isEmptyOrNull) {
      products.value = allProducts;
    } else {
      final data = allProducts;
      products.value = data.filter((element) => element.title?.toLowerCase().contains(text) ?? true).toList();
    }
  }

  Future<void> getProducts() async {
    products.clear();
    allProducts.clear();
    category.clear();
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
    }).catchError((dynamic error) {
      isLoading.value = false;
      logE(error);
    });
  }
}
