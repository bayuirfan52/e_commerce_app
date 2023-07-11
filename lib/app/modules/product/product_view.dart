import 'package:e_commerce_app/app/core/resource/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

import 'product_controller.dart';

class ProductView extends GetView<ProductController> {
  const ProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          '',
          maxLines: 1,
          overflow: TextOverflow.fade,
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
        actions: [
          Material(
            type: MaterialType.transparency,
            child: Ink(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade500),
                color: Colors.grey.shade50,
                shape: BoxShape.circle,
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(1000),
                onTap: () {},
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: ZStack([
                    Icon(
                      Icons.shopping_cart,
                      size: 24,
                      color: Colors.black,
                    ),
                    Positioned(
                      left: 12,
                      bottom: 12,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.red.shade400,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '9+',
                          style: GoogleFonts.roboto(
                            fontSize: 10,
                            color: Colors.white,
                          ),
                        ).p4(),
                      ),
                    ),
                  ]).centered(),
                ),
              ),
            ),
          ).pOnly(right: 24),
        ],
      ),
      body: controller.obx(
        (state) => VStack([
          Image.network(
            state?.image ?? '',
            fit: BoxFit.contain,
            height: 300,
          ).centered(),
          SizedBox(height: 24),
          Text(
            state?.category?.capitalized ?? '',
            style: GoogleFonts.roboto(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: colorUfoGreen,
            ),
          ),
          SizedBox(height: 8),
          Text(
            state?.title ?? '',
            style: GoogleFonts.roboto(
              fontSize: 24,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 16),
          HStack(
            [
              Icon(
                Icons.star,
                color: Colors.amber,
                size: 18,
              ),
              SizedBox(width: 4),
              Text(
                state?.rating?.rate?.toString() ?? '',
                style: GoogleFonts.roboto(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              SizedBox(width: 8),
              Text(
                '-',
                style: GoogleFonts.roboto(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey,
                ),
              ),
              SizedBox(width: 8),
              Text(
                '${state?.rating?.count?.toInt()} Reviews',
                style: GoogleFonts.roboto(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: colorUfoGreen,
                ),
              ),
            ],
            alignment: MainAxisAlignment.center,
          ),
          SizedBox(height: 24),
          Text(
            'Description',
            style: GoogleFonts.roboto(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 8),
          Text(
            state?.description ?? '',
            style: GoogleFonts.roboto(
              fontSize: 14,
              fontWeight: FontWeight.w300,
              color: Colors.black,
            ),
          ),
        ]).p24().scrollVertical(),
        onLoading: SizedBox(),
        onError: (error) => Text('$error').centered(),
      ),
      bottomNavigationBar: controller.obx(
        (state) => HStack([
          Text(
            '\$ ${state?.price}',
            style: GoogleFonts.roboto(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          Spacer(),
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
              'Add to Cart',
              style: GoogleFonts.roboto(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
          ),
          SizedBox(width: 8),
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
              'Buy',
              style: GoogleFonts.roboto(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
          )
        ]).p24(),
      ),
    );
  }
}
