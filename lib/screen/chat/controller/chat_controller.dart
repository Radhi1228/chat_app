import 'package:get/get.dart';

import '../../../utils/helper/fire_db_helper.dart';

class ChatController extends GetxController
{
  Stream? dataSnap;

  void getChat(){
    dataSnap = FireDbHelper.helper.readChat();
  }
}