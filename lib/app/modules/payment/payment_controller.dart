import 'dart:async';

import 'package:e_commerce_app/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class PaymentController extends GetxController {
  final dummyQris = 'https://ps.w.org/doqrcode/assets/icon-256x256.png?rev=2143781';
  final totalPayment = 0.0.obs;
  final time = (60 * 15).obs;
  Timer? timer;

  @override
  void onInit() {
    super.onInit();
    totalPayment.value = Get.arguments as double;
  }

  @override
  void onReady() {
    super.onReady();
    _startTimer();
  }

  Future<void> onBack() async {
    final box = await Hive.openBox<dynamic>('products');
    await box.clear();
    await box.close();
    await Get.offAllNamed<dynamic>(Routes.HOME);
  }

  void _startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (time.value == 0) {
        timer.cancel();
      } else {
        time.value -= 1;
      }
    });

  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }
}
