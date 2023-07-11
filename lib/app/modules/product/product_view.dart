import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'product_controller.dart';

class ProductView extends GetView<ProductController> {
  const ProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(controller.data.value.title ?? '', maxLines: 1, overflow: TextOverflow.fade,)),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ProductView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
