import 'package:chatapp_firebase/screen/profile/model/profile_model.dart';
import 'package:chatapp_firebase/utils/helper/fire_db_helper.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController
{
  ProfileModel? profileModel;

  Future<void> getSignInData()
  async {
    profileModel = await FireDbHelper.helper.getSignInProfile();

  }
}