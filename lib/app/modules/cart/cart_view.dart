import 'package:e_commerce_app/app/core/resource/app_color.dart';
import 'package:e_commerce_app/app/widget/empty_widget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

import 'cart_controller.dart';

class CartView extends GetView<CartController> {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Cart',
          maxLines: 1,
          overflow: TextOverflow.fade,
          style: GoogleFonts.roboto(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back<dynamic>();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ).marginOnly(left: 16),
      ),
      body: VStack([
        Text(
          'Your Cart',
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.w400,
            fontSize: 24,
          ),
        ),
        SizedBox(height: 24),
        Obx(
          () => controller.listCart.isNotEmpty
              ? ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final item = controller.listCart[index];
                    return ListTile(
                      leading: Image.network(
                        item.image ?? '',
                        width: 56,
                        fit: BoxFit.contain,
                      ),
                      contentPadding: EdgeInsets.all(12),
                      title: Text(
                        item.title ?? '',
                        style: GoogleFonts.roboto(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      trailing: HStack([
                        Text(
                          '\$ ${item.price}',
                          style: GoogleFonts.roboto(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        IconButton(
                          onPressed: () => alert(() => controller.removeProduct(index)),
                          icon: Icon(
                            Icons.delete,
                            color: Colors.grey.shade400,
                          ),
                        )
                      ]),
                    );
                  },
                  separatorBuilder: (context, index) => Divider(
                    color: colorBorder,
                    height: 2,
                  ),
                  itemCount: controller.listCart.length,
                )
              : EmptyWidget(
                  message: 'Cart is Empty',
                ),
        )
      ]).p24().scrollVertical(),
      bottomNavigationBar: Obx(
        () => Visibility(
          visible: controller.listCart.isNotEmpty,
          child: VStack([
            HStack([
              Text(
                'Total Payment',
                style: GoogleFonts.roboto(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Spacer(),
              Obx(
                () => Text(
                  '\$ ${controller.totalPayment}',
                  style: GoogleFonts.roboto(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              )
            ]),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => controller.checkout(),
              style: ButtonStyle(
                shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              child: Text(
                'Checkout',
                style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
            ).wFull(context).h(48),
          ]).p24(),
        ),
      ),
    );
  }

  void alert(Function callback) {
    Get.dialog<dynamic>(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
        insetPadding: EdgeInsets.symmetric(horizontal: 60),
        content: VStack(
          [
            Center(
              child: VStack([
                Icon(
                  Icons.warning,
                  color: Colors.amber,
                  size: 56,
                ).centered(),
                16.heightBox,
                Text(
                  'Are you sure to remove this product?',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ).centered(),
              ]),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Get.back<dynamic>(),
            style: ElevatedButton.styleFrom(
              backgroundColor: colorGrey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'Cancel',
              style: GoogleFonts.roboto(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
          ),
          SizedBox(width: 8),
          ElevatedButton(
            onPressed: () {
              Get.back<dynamic>();
              callback.call();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade700,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'Remove',
              style: GoogleFonts.roboto(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
          )
        ],
      ),
    );
  }
}
