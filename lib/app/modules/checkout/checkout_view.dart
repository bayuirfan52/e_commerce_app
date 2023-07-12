import 'package:e_commerce_app/app/core/resource/app_color.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

import 'checkout_controller.dart';

class CheckoutView extends GetView<CheckoutController> {
  const CheckoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Checkout',
          maxLines: 1,
          overflow: TextOverflow.fade,
          style: GoogleFonts.roboto(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w400,
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
          'Order Summary',
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.w400,
            fontSize: 24,
          ),
        ),
        SizedBox(height: 24),
        Obx(
          () => ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final item = controller.listCart[index];
              return ListTile(
                leading: Image.network(
                  item.image ?? '',
                  width: 56,
                  fit: BoxFit.contain,
                ),
                contentPadding: EdgeInsets.all(16),
                title: Text(
                  item.title ?? '',
                  style: GoogleFonts.roboto(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                trailing: Text(
                  '\$ ${item.price}',
                  style: GoogleFonts.roboto(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => Divider(
              color: colorBorder,
              height: 2,
            ),
            itemCount: controller.listCart.length,
          ),
        )
      ]).p24().scrollVertical(),
      bottomNavigationBar: VStack([
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
        SizedBox(height: 8),
        HStack([
          Text(
            'Current Payment Method',
            style: GoogleFonts.roboto(
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
          Spacer(),
          Text(
            'QRIS',
            style: GoogleFonts.roboto(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ]),
        SizedBox(height: 24),
        ElevatedButton(
          onPressed: () {},
          style: ButtonStyle(
            shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          child: Text(
            'Proceed to Payment',
            style: GoogleFonts.roboto(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          ),
        ).wFull(context).h(48),
      ]).p24(),
    );
  }
}
