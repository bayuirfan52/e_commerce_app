import 'package:e_commerce_app/app/core/base/base_controller.dart';
import 'package:e_commerce_app/app/helper/ex_log.dart';
import 'package:e_commerce_app/app/model/products_entity.dart';
import 'package:e_commerce_app/app/modules/product/product_repository.dart';
import 'package:get/get.dart';

class ProductController extends BaseController<ProductRepository> {
  final id = ''.obs;
  final data = ProductsEntity().obs;

  @override
  void onInit() {
    super.onInit();
    id.value = Get.arguments as String;
  }

  @override
  void onReady() {
    super.onReady();
    _getDetailProduct(id.value);
  }

  Future<void> _getDetailProduct(String id) async {
    await repo.getProduct(id).then((value) {
      final response = ProductsEntity.fromJson(value.body as Map<String, dynamic>);
      data.value = response;
    }).catchError((dynamic error) {
      logE(error);
    });
  }
}
