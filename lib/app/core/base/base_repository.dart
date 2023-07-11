import 'package:e_commerce_app/app/core/networking/http.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
abstract class BaseRepository {
  @protected
  final apiService = Get.find<HttpService>();
}
