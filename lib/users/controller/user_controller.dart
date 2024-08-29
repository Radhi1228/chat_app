import 'package:chatapp_firebase/screen/profile/model/profile_model.dart';
import 'package:chatapp_firebase/utils/helper/fire_db_helper.dart';
import 'package:get/get.dart';

class UserController extends GetxController
{
  RxList<ProfileModel> profileList = <ProfileModel>[].obs;

  Future<void> getUserData()
  async {
    profileList.value = await FireDbHelper.helper.getAllUser();
  }
}