import 'package:chatapp_firebase/utils/color/app_color.dart';
import 'package:chatapp_firebase/utils/routes/app_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';

void main()
async{
WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
      GetMaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          colorSchemeSeed: fav,
        ),
      debugShowCheckedModeBanner: false,
      routes: appRoutes,
    )
  );
}