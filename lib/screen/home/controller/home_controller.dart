import 'package:chatapp_firebase/utils/helper/shared_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/helper/fire_db_helper.dart';
import '../../profile/model/profile_model.dart';

class HomeController extends GetxController
{
  Stream<QuerySnapshot<Map>>? chatUsers;
  ProfileModel? model;
  RxList<ProfileModel> userList = <ProfileModel>[].obs;

  bool theme = false;
  bool isTheme = false;
  ThemeMode mode = ThemeMode.dark;
  bool isOn = true;
  IconData themeMode = Icons.dark_mode;


  void setThemeData() async {
    theme = !theme;
    SharedHelper.helper.setData(isTheme: theme);
    isTheme = (await SharedHelper.helper.getData())!;
    if (isTheme == true) {
      mode = ThemeMode.dark;
      themeMode = Icons.light_mode;
    } else if (isTheme == false) {
      mode = ThemeMode.light;
      themeMode = Icons.dark_mode;
    }

  }

  void changeTheme() {
    isOn = !isOn;

  }

  void getThemeData() async {
    if (await SharedHelper.helper.getData() == null) {
      isTheme = false;
    } else {
      isTheme = (await SharedHelper.helper.getData())!;
    }
    if (isTheme == true) {
      mode = ThemeMode.dark;
      themeMode = Icons.light_mode;
    } else if (isTheme == false) {
      mode = ThemeMode.light;
      themeMode = Icons.dark_mode;
    } else {
      mode = ThemeMode.dark;
      themeMode = Icons.light_mode;
    }
  }

  void getUsers() {
    chatUsers = FireDbHelper.helper.getMyChatUser();
  }

  Future<void> getUIDUsers(receiverId) async{
    model = await FireDbHelper.helper.getUIDUsers(receiverId);
  }

}