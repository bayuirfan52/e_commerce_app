import 'package:e_commerce_app/app/core/base/base_repository.dart';
import 'package:e_commerce_app/app/core/networking/http.dart';
import 'package:e_commerce_app/app/model/products_entity.dart';
import 'package:hive/hive.dart';

class HomeRepository extends BaseRepository {
  Future<Outcome> getProducts() => apiService.httpGet(endPoint: 'products');

  Future<List<ProductsEntity>> getCartData() async {
    final box = await Hive.openBox<dynamic>('products');
    final list = <ProductsEntity>[];
    for (var i = 0; i < box.length ; i++) {
      final item = box.getAt(i);
      final product = ProductsEntity();
      final rating = ProductsRating();
      product.id = item['id'] as double;
      product.title = item['title'] as String;
      product.price = item['price'] as double;
      product.description = item['description'] as String;
      product.category = item['category'] as String;
      product.image = item['image'] as String;
      product.id = item['id'] as double;
      rating.count = item['rating']['count'] as double;
      rating.rate = item['rating']['rate'] as double;
      product.rating = rating;
      list.add(product);
    }
    await box.close();
    return list;
  }
}
