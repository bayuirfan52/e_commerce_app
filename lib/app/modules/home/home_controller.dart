import 'package:e_commerce_app/app/core/base/base_controller.dart';
import 'package:e_commerce_app/app/helper/ex_log.dart';
import 'package:e_commerce_app/app/model/products_entity.dart';
import 'package:e_commerce_app/app/modules/home/home_repository.dart';
import 'package:e_commerce_app/app/routes/app_pages.dart';
import 'package:get/get.dart';

class HomeController extends BaseController<HomeRepository> {
  final category = <String>[].obs;
  final products = <ProductsEntity>[].obs;
  final allProducts = <ProductsEntity>[].obs;
  final selectedCategory = ''.obs;

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

  Future<void> getProducts() async {
    products.clear();
    allProducts.clear();
    category.clear();
    await repo.getProducts().then((value) {
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
      logE(error);
    });
  }
}
