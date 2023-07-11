import 'package:e_commerce_app/app/core/networking/http.dart';
import 'package:e_commerce_app/app/helper/ex_log.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

class Dependencies {
  Dependencies._();

  static Future<void> init() async {
    GoogleFonts.config.allowRuntimeFetching = false;
    await ExLog.init();
    await GetStorage.init();
    Get.lazyPut<GetStorage>(() => GetStorage());
    Get.put(
      HttpService(
        baseURL: 'https://fakestoreapi.com/',
        baseHeader: {},
        maxTimeOut: 60.seconds,
        allowFollowRedirects: true,
        showLogHeader: kDebugMode,
        showLogResponse: kDebugMode,
      ),
    );

  }
}
