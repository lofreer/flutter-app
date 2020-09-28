import 'dart:io';

import 'package:demo/util/app_manager.dart';
import 'package:demo/util/constant.dart';

class MineRepository {
  static Future<String> getAvatarPath() async {
    return AppManager.prefs.getString(Constant.userAvatarPath);
  }

  static saveAvatarPath(File file) async {
    AppManager.prefs.setString(Constant.userAvatarPath, file.path);
  }
}
