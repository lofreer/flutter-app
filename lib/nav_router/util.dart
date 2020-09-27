import 'package:flutter/material.dart';
import 'package:demo/nav_router/enum.dart';
import 'package:demo/nav_router/router.dart';

/// This function is a wrapper for the route jump animation.
/// You can directly pass an enumeration method and the page uses this method.
///
/// example:
/// ```dart
/// routerUtil(type: RouterType.material, widget: NewPage());
/// ```
///
Route routerUtil({RouterType type, widget}) {
  Route route;
  switch (type) {
    case RouterType.material:
      route = materialRoute(widget);
      break;
    case RouterType.cupertino:
      route = cupertinoRoute(widget);
      break;
  }

  return route;
}
