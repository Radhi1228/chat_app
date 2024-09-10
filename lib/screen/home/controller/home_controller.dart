import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../utils/helper/fire_db_helper.dart';
import '../../profile/model/profile_model.dart';

class HomeController extends GetxController
{
  Stream<QuerySnapshot<Map>>? chatUsers;
  ProfileModel? model;
  RxList<ProfileModel> userList = <ProfileModel>[].obs;

  void getUsers() {
    chatUsers = FireDbHelper.helper.getMyChatUser();
  }
  Future<void> getUIDUsers(receiverId)
  async{
    model = await FireDbHelper.helper.getUIDUsers(receiverId);
  }
}