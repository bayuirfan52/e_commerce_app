import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

mixin LoadingHelper {
  static void show({
    bool isDismissible = false,
    String? message = '',
    double? messageSize = 14,
  }) {
    Get.dialog<dynamic>(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
        insetPadding: EdgeInsets.symmetric(horizontal: 120),
        content: VStack(
          [
            Center(
              child: VStack([
                Image.asset('assets/images/gif_loading.gif'),
                if (!message.isEmptyOrNull)
                  VStack([
                    16.heightBox,
                    message!.text.align(TextAlign.center).size(messageSize).makeCentered(),
                  ]).centered(),
              ]),
            ),
          ],
        ),
      ),
      barrierDismissible: isDismissible,
    );
  }

  static void dismiss() {
    if (Get.isDialogOpen ?? true) {
      Get.back<dynamic>();
    }
  }
}
