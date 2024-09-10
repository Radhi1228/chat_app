import 'package:chatapp_firebase/screen/chat/view/chat_screen.dart';
import 'package:chatapp_firebase/screen/home/view/home_screen.dart';
import 'package:chatapp_firebase/screen/login/view/signin_screen.dart';
import 'package:chatapp_firebase/screen/login/view/signup_screen.dart';
import 'package:chatapp_firebase/screen/profile/view/profile_screen.dart';
import 'package:chatapp_firebase/screen/splash/view/splash_screen.dart';
import 'package:flutter/material.dart';
import '../../screen/users/view/alluser_screen.dart';

Map<String,WidgetBuilder> appRoutes =
{
  '/' : (c1) => const SplashScreen(),
  '/signIn' : (c1) => const SignInScreen(),
  '/signUp' : (c1) => const SignUpScreen(),
  '/home' : (c1) => const HomeScreen(),
  '/profile' : (c1) => const ProfileScreen(),
  '/user' : (c1) => const AllUserScreen(),
  '/chat' : (c1) => const ChatScreen(),
};