import 'dart:async';
import 'package:chatapp_firebase/utils/helper/auth_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../../../utils/color/app_color.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {

    bool logIN = AuthHelper.helper.checkUser();
    Future.delayed(
      const Duration(seconds: 4),
      () {
        Get.offAllNamed(logIN ? '/home' : '/signIn');
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.chat,size: 120,color: fav,
            ),
            Text("Chatify",style: TextStyle(color: fav,fontSize: 25),)
          ],
        ),
      ),
    );
  }
}
