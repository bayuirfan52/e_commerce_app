import 'package:e_commerce_app/app/core/base/base_repository.dart';
import 'package:e_commerce_app/app/core/networking/http.dart';

class ProductRepository extends BaseRepository {
  Future<Outcome> getProduct(String id) => apiService.httpGet(endPoint: 'products/$id');
}
