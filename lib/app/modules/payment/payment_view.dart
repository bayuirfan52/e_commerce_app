import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

import 'payment_controller.dart';

class PaymentView extends GetView<PaymentController> {
  const PaymentView({super.key});

  @override
  Widget build(BuildContext context) => WillPopScope(
    onWillPop: () async {
      await controller.onBack();
      return false;
    },
    child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Payment',
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
              controller.onBack();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ).marginOnly(left: 16),
        ),
        body: VStack([
          16.heightBox,
          Image.network(controller.dummyQris).centered(),
          48.heightBox,
          Divider(
            height: 2,
            thickness: 2,
          ),
          24.heightBox,
          HStack([
            Text(
              'Amount',
              style: GoogleFonts.roboto(
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
            Spacer(),
            Text(
              '\$ ${controller.totalPayment.value}',
              style: GoogleFonts.roboto(
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
          ]),
          24.heightBox,
          Divider(
            height: 2,
            thickness: 2,
          ),
          24.heightBox,
          HStack([
            Text(
              'Time Remaining',
              style: GoogleFonts.roboto(
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
            Spacer(),
            Obx(
              () => Text(
                '${controller.time.value ~/ 60}:${controller.time.value % 60}',
                style: GoogleFonts.roboto(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Colors.red,
                ),
              ),
            ),
          ]),
        ]).p24(),
      ),
  );
}
