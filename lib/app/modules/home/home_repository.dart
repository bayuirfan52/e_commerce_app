import 'package:e_commerce_app/app/core/base/base_repository.dart';
import 'package:e_commerce_app/app/core/networking/http.dart';

class HomeRepository extends BaseRepository {
  Future<Outcome> getProducts() => apiService.httpGet(endPoint: 'products');
}
