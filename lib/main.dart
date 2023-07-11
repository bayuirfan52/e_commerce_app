import 'dart:async';

import 'package:e_commerce_app/app/core/resource/app_theme.dart';
import 'package:e_commerce_app/app/helper/ex_log.dart';
import 'package:e_commerce_app/app/routes/app_pages.dart';
import 'package:e_commerce_app/dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

Future<void> main() async {
  await runZonedGuarded(() async {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.dark));
    WidgetsFlutterBinding.ensureInitialized();
    await Dependencies.init();
    runApp(App());
  }, (error, stack) {
    logE('$error');
  });
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => GetMaterialApp(
        theme: AppThemes.theme,
        debugShowCheckedModeBanner: false,
        defaultTransition: Transition.native,
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        builder: (context, child) {
          return child!;
        },
      );
}
