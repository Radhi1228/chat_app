import 'package:chatapp_firebase/utils/helper/shared_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import '../../../utils/helper/fire_db_helper.dart';
import '../../profile/model/profile_model.dart';

class HomeController extends GetxController
{
  Stream<QuerySnapshot<Map>>? chatUsers;
  ProfileModel? model;
  RxList<ProfileModel> userList = <ProfileModel>[].obs;

  RxBool isTheme = false.obs;
  Rx<ThemeMode> mode = ThemeMode.dark.obs;
  bool isOn = true;
  IconData themeMode = Icons.dark_mode;


  void setThemeData() async {
    isTheme.value = !isTheme.value;
    SharedHelper.helper.setData(isTheme: isTheme.value);
    isTheme.value = (await SharedHelper.helper.getData())??false;
    if (isTheme == true) {
      mode.value = ThemeMode.dark;
      themeMode = Icons.light_mode;
    } else if (isTheme == false) {
      mode.value = ThemeMode.light;
      themeMode = Icons.dark_mode;
    }

  }

  void getThemeData() async {
    if (await SharedHelper.helper.getData() == null) {
      isTheme.value = false;
    } else {
      isTheme.value = (await SharedHelper.helper.getData())!;
    }
    if (isTheme == true) {
      mode.value = ThemeMode.dark;
      themeMode = Icons.light_mode;
    } else if (isTheme == false) {
      mode.value = ThemeMode.light;
      themeMode = Icons.dark_mode;
    } else {
      mode.value = ThemeMode.dark;
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