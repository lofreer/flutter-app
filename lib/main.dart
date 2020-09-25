import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:demo/navigation/tab_navigation.dart';
import 'package:demo/util/app_manager.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // 初始化
    AppManager.init();

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      navigatorKey: Get.key,
      home: TabNavigation()
    );
  }
}
