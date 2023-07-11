import 'package:get/get.dart';

import '../modules/cart/cart_binding.dart';
import '../modules/cart/cart_view.dart';
import '../modules/checkout/checkout_binding.dart';
import '../modules/checkout/checkout_view.dart';
import '../modules/home/home_binding.dart';
import '../modules/home/home_view.dart';
import '../modules/notification/notification_binding.dart';
import '../modules/notification/notification_view.dart';
import '../modules/product/product_binding.dart';
import '../modules/product/product_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage<dynamic>(
      name: Routes.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.PRODUCT,
      page: () => const ProductView(),
      binding: ProductBinding(),
    ),
    GetPage(
      name: Routes.CART,
      page: () => const CartView(),
      binding: CartBinding(),
    ),
    GetPage(
      name: Routes.NOTIFICATION,
      page: () => const NotificationView(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: Routes.CHECKOUT,
      page: () => const CheckoutView(),
      binding: CheckoutBinding(),
    ),
  ];
}
