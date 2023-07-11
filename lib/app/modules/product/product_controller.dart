import 'package:e_commerce_app/app/core/base/base_controller.dart';
import 'package:e_commerce_app/app/helper/loading_helper.dart';
import 'package:e_commerce_app/app/model/products_entity.dart';
import 'package:e_commerce_app/app/modules/product/product_repository.dart';
import 'package:get/get.dart';

class ProductController extends BaseController<ProductRepository> with StateMixin<ProductsEntity> {
  final id = ''.obs;

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
