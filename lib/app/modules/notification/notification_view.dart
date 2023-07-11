import 'package:e_commerce_app/app/core/resource/app_color.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

import 'notification_controller.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Notification',
          maxLines: 1,
          overflow: TextOverflow.fade,
          style: GoogleFonts.roboto(
            color: Colors.black,
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
      body: ListView.separated(
        separatorBuilder: (context, index) => SizedBox(height: 16),
        itemBuilder: (context, index) => ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: colorBorder)
          ),
          leading: Icon(Icons.notifications_none),
          title: Text('Anda Mendapatkan ${index + 1} Notifikasi'),
          onTap: (){},
        ),
        itemCount: 5,
      ).p24(),
    );
  }
}
