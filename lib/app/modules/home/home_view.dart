import 'package:e_commerce_app/app/core/resource/app_color.dart';
import 'package:e_commerce_app/app/widget/ex_textfield_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

import 'home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: VStack([
        SizedBox(height: 24),
        HStack([
          Text(
            'Discover',
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.w400,
              fontSize: 36,
            ),
          ),
          Spacer(),
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
                onTap: () => controller.goToNotification(),
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Icon(
                    Icons.notifications,
                    size: 24,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 8),
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
                onTap: () => controller.goToCart(),
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: ZStack([
                    Icon(
                      Icons.shopping_cart,
                      size: 24,
                    ),
                    Obx(
                      () => Visibility(
                        visible: controller.cart.isNotEmpty,
                        child: Positioned(
                          left: 12,
                          bottom: 12,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: Colors.red.shade400,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              '${controller.cart.length > 9 ? '9+' : controller.cart.length}',
                              style: GoogleFonts.roboto(
                                fontSize: 10,
                                color: Colors.white,
                              ),
                            ).p4(),
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
            ),
          ),
        ]),
        SizedBox(height: 48),
        ExTextFieldIcon(
          hint: 'Search',
          tfController: controller.searchController,
          prefixIcon: Icons.search_rounded,
          onChanged: (text) => controller.searchData(text),
        ),
        SizedBox(height: 16),
        Obx(
          () => controller.isLoading.value
              ? SizedBox()
              : SizedBox(
                  height: 40,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (context, index) => SizedBox(width: 8),
                    itemBuilder: (context, index) => Obx(
                      () => DecoratedBox(
                        decoration: BoxDecoration(
                          color: controller.selectedCategory.value == controller.category[index] ? colorUfoGreen : Colors.transparent,
                          border: Border.all(color: controller.selectedCategory.value == controller.category[index] ? colorUfoGreen : Colors.grey.shade200, width: 2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          controller.category[index].capitalized,
                          style: GoogleFonts.roboto(
                            fontSize: 14,
                            color: controller.selectedCategory.value == controller.category[index] ? Colors.white : Colors.grey.shade500,
                          ),
                        ).pSymmetric(v: 4, h: 16).centered().onInkTap(() => controller.filterData(index)),
                      ),
                    ),
                    itemCount: controller.category.length,
                  ),
                ),
        ),
        SizedBox(height: 16),
        Obx(
          () => controller.isLoading.value
              ? SizedBox()
              : GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 4,
                    childAspectRatio: 5.1,
                    mainAxisSpacing: 4,
                    mainAxisExtent: 220,
                  ),
                  itemBuilder: (context, index) {
                    final item = controller.products[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.grey.shade200),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      elevation: 3,
                      child: VStack([
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                          child: Image.network(
                            item.image ?? '',
                            height: 150,
                            fit: BoxFit.fitWidth,
                          ).centered(),
                        ),
                        SizedBox(height: 8),
                        Text(
                          item.title ?? '',
                          style: GoogleFonts.roboto(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                        ).centered().marginSymmetric(horizontal: 8),
                        SizedBox(height: 8),
                        Text(
                          '\$ ${item.price}',
                          style: GoogleFonts.roboto(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ).centered().marginSymmetric(horizontal: 8),
                      ]).pOnly(bottom: 8).onInkTap(() => controller.goToDetailProduct(item.id.toString())),
                    );
                  },
                  itemCount: controller.products.length,
                  physics: ClampingScrollPhysics(),
                  padding: EdgeInsets.zero,
                ),
        ).expand(),
      ]).p24(),
    );
  }
}
