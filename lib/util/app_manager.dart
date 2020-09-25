import 'package:shared_preferences/shared_preferences.dart';

class AppManager {
  AppManager._();

  static SharedPreferences prefs;

  //App初始化工作
  static init() async {
    prefs = await SharedPreferences.getInstance();
  }
}
