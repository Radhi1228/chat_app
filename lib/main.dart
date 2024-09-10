import 'package:chatapp_firebase/screen/home/controller/home_controller.dart';
import 'package:chatapp_firebase/utils/color/app_color.dart';
import 'package:chatapp_firebase/utils/routes/app_routes.dart';
import 'package:chatapp_firebase/utils/services/notify_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';
import 'package:timezone/data/latest.dart' as tz;

void main()
async{
WidgetsFlutterBinding.ensureInitialized();
HomeController controller = Get.put(HomeController());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  NotificationService.notificationService.initNotification();
  tz.initializeTimeZones();
  controller.getThemeData();
  runApp(
      GetMaterialApp(
        themeMode: controller.mode,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          colorSchemeSeed: fav,
        ),
      debugShowCheckedModeBanner: false,
      routes: appRoutes,
    )
  );
}