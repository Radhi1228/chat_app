import 'package:shared_preferences/shared_preferences.dart';

class SharedHelper {
  static SharedHelper helper = SharedHelper._();
  SharedHelper._();

  void setData({required bool isTheme}) async {
    SharedPreferences shr = await SharedPreferences.getInstance();
    shr.setBool("theme", isTheme);
  }

  Future<bool?> getData() async {
    SharedPreferences shr = await SharedPreferences.getInstance();
    return shr.getBool("theme");
  }
}