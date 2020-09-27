import 'package:flutter/material.dart';
import './page/home/home.dart';
import './page/discovery/discovery.dart';
import './page/mine/mine.dart';

// 另一种方式 但，这里有页面概念吗？

class Router {
  // 路由声明
  static Map<String, Function> routes = {
    '/home': (context, {arguments}) => HomePage(),
    '/discovery': (context) => DiscoveryPage(),
  };
  static run(RouteSettings settings) {
    final Function pageContentBuilder = Router.routes[settings.name];

    if (pageContentBuilder != null) {
      if (settings.arguments != null) {
        // 传参路由
        return MaterialPageRoute(
            builder: (context) => pageContentBuilder(context, arguments: settings.arguments));
      } else {
        // 无参数路由
        return MaterialPageRoute(
          builder: (context) => pageContentBuilder(context));
      }
    } else {
      // 404页
      return MaterialPageRoute(builder: (context) => MinePage());
    }
  }
}
