import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:demo/nav_router/enum.dart';
import 'package:demo/nav_router/util.dart';

class NavigatorManager {

  NavigatorManager._();


  /// This is the key used for route redirection.
  /// It must be set in the materialApp's navigatorKey property.
  ///
  /// example:
  /// ```dart
  /// class MyApp extends StatelessWidget {
  ///   @override
  ///   Widget build(BuildContext context) {
  ///     return new MaterialApp(
  ///       title: 'NavRoute',
  ///       navigatorKey: navigatorKey,
  ///       home: new MyHomePage(),
  ///     );
  ///   }
  /// }
  /// ```
  static final navigatorKey = new GlobalKey<NavigatorState>();

  /// The direct route jump method can also directly set the route jump mode.
  ///
  /// example:
  /// push(NewPage(),RouterType.fade)
  ///
  static Future<dynamic> push(Widget page,
      [RouterType type = RouterType.cupertino]) {
    Route route = routerUtil(type: type, widget: page);
    return navigatorKey.currentState.push(route);
  }

  /// The route is redirected by the route name,
  /// which can be used by directly passing in the route name.
  ///
  ///
  /// Push a named route onto the navigator.
  ///
  /// {@macro flutter.widgets.navigator.pushNamed}
  ///
  /// {@macro flutter.widgets.navigator.pushNamed.arguments}
  ///
  /// {@tool sample}
  ///
  /// Typical usage is as follows:
  ///
  /// ```dart
  /// void _aaronBurrSir() {
  ///   pushNamed('/nyc/1776');
  /// }
  /// ```
  /// {@end-tool}
  static Future<dynamic> pushNamed(String name) {
    return navigatorKey.currentState.pushNamed(name);
  }

  /// Whether the route can be popped out of the stack,
  /// if it can be popped out, otherwise nothing is done.
  ///
  /// Tries to pop the current route, while honoring the route's [Route.willPop]
  /// state.
  ///
  /// {@macro flutter.widgets.navigator.maybePop}
  ///
  /// See also:
  ///
  ///  * [Form], which provides an `onWillPop` callback that enables the form
  ///    to veto a [pop] initiated by the app's back button.
  ///  * [ModalRoute], which provides a `scopedWillPopCallback` that can be used
  ///    to define the route's `willPop` method.
  static Future<dynamic> maybePop([result]) {
    return navigatorKey.currentState.maybePop(result);
  }

  /// The routing stack is replaced by the routing name.
  ///
  ///
  /// Replace the current route of the navigator by pushing the route named
  /// [routeName] and then disposing the previous route once the new route has
  /// finished animating in.
  ///
  /// {@macro flutter.widgets.navigator.pushReplacementNamed}
  ///
  /// {@macro flutter.widgets.navigator.pushNamed.arguments}
  ///
  /// {@tool sample}
  ///
  /// Typical usage is as follows:
  ///
  /// ```dart
  /// void _startBike() {
  ///   pushReplacementNamed('/jouett/1781');
  /// }
  /// ```
  /// {@end-tool}
  static Future<dynamic> pushReplacementNamed(routeName, [result]) {
    return navigatorKey.currentState.pushReplacementNamed(routeName, result: result);
  }

  /// Pop the current route off the navigator and push a named route in its
  /// place.
  ///
  /// {@macro flutter.widgets.navigator.popAndPushNamed}
  ///
  /// {@macro flutter.widgets.navigator.pushNamed.arguments}
  ///
  /// {@tool sample}
  ///
  /// Typical usage is as follows:
  ///
  /// ```dart
  /// void _begin() {
  ///   popAndPushNamed('/nyc/1776');
  /// }
  /// ```
  /// {@end-tool}
  static Future<dynamic> popAndPushNamed(name, [result]) {
    return navigatorKey.currentState.popAndPushNamed(name, result: result);
  }

  /// Push the given route onto the navigator, and then remove all the previous
  /// routes until the `predicate` returns true.
  ///
  /// {@macro flutter.widgets.navigator.pushAndRemoveUntil}
  ///
  /// {@tool sample}
  ///
  /// Typical usage is as follows:
  ///
  /// ```dart
  /// void _resetAndOpenPage() {
  ///   pushAndRemoveUntil(
  ///     MaterialPageRoute(builder: (BuildContext context) => MyHomePage()),
  ///     ModalRoute.withName('/'),
  ///   );
  /// }
  /// ```
  /// {@end-tool}
  static Future<dynamic> pushAndRemoveUntil(Widget page,
      [RouterType type = RouterType.cupertino]) {
    Route route = routerUtil(type: type, widget: page);
    return navigatorKey.currentState
        .pushAndRemoveUntil(route, (Route<dynamic> route) => false);
  }

  ///```dart
  /// pushNamedAndRemoveUntil("/screen4",ModalRoute.withName('/')
  /// ```
  static Future<dynamic> pushNamedAndRemoveUntil(String newRouteName) {
    return navigatorKey.currentState
        .pushNamedAndRemoveUntil(newRouteName, (Route<dynamic> route) => false);
  }

  /// Replace the current route of the navigator by pushing the given route and
  /// then disposing the previous route once the new route has finished
  /// animating in.
  ///
  /// {@macro flutter.widgets.navigator.pushReplacement}
  ///
  /// {@tool sample}
  ///
  /// Typical usage is as follows:
  ///
  /// ```dart
  /// void _doOpenPage() {
  ///   pushReplacement(
  ///       MaterialPageRoute(builder: (BuildContext context) => MyHomePage()));
  /// }
  /// ```
  /// {@end-tool}
  static Future<dynamic> pushReplacement(Widget page,
      [RouterType type = RouterType.cupertino]) {
    Route route = routerUtil(type: type, widget: page);
    return navigatorKey.currentState.pushReplacement(route);
  }

  /// Calls [pop] repeatedly until the predicate returns true.
  ///
  /// {@macro flutter.widgets.navigator.popUntil}
  ///
  /// {@tool sample}
  ///
  /// Typical usage is as follows:
  ///
  /// ```dart
  /// void _doLogout() {
  ///   popToRootPage(ModalRoute.withName('/'));
  /// }
  /// ```
  /// {@end-tool}
  ///
  /// This method pops directly to the root page
  static void popToRootPage() {
    navigatorKey.currentState.popUntil(ModalRoute.withName('/'));
  }

  /// You can pop to the existing page of the routing stack.
  ///
  static void popToPage(Widget page) {
    popUntil(ModalRoute.withName(page.toStringShort()));
  }

  ///
  /// Calls [pop] repeatedly until the predicate returns true.
  ///
  /// {@macro flutter.widgets.navigator.popUntil}
  ///
  /// ```dart
  ///   popUntil(ModalRoute.withName('/login'));
  /// ```
  static void popUntil(RoutePredicate predicate) {
    return navigatorKey.currentState.popUntil(predicate);
  }

  /// Immediately remove `route` from the navigator, and [Route.dispose] it.
  ///
  /// {@macro flutter.widgets.navigator.removeRoute}
  static void removeRoute(Route<dynamic> route) {
    return navigatorKey.currentState.removeRoute(route);
  }

  /// Immediately remove a route from the navigator, and [Route.dispose] it. The
  /// route to be replaced is the one below the given `anchorRoute`.
  ///
  /// {@macro flutter.widgets.navigator.removeRouteBelow}
  static void removeRouteBelow(Route<dynamic> anchorRoute) {
    return navigatorKey.currentState.removeRouteBelow(anchorRoute);
  }

  /// Replaces a route on the navigator with a new route.
  ///
  /// {@macro flutter.widgets.navigator.replace}
  ///
  /// See also:
  ///
  ///  * [replaceRouteBelow], which is the same but identifies the route to be
  ///    removed by reference to the route above it, rather than directly.
  static void replaceRouter<T extends Object>(
      {@required Route<dynamic> oldRoute, @required Route<T> newRoute}) {
    return navigatorKey.currentState.replace(oldRoute: oldRoute, newRoute: newRoute);
  }

  /// Replaces a route on the navigator with a new route. The route to be
  /// replaced is the one below the given `anchorRoute`.
  ///
  /// {@macro flutter.widgets.navigator.replaceRouteBelow}
  ///
  /// See also:
  ///
  ///  * [replace], which is the same but identifies the route to be removed
  ///    directly.
  static void replaceRouteBelow<T extends Object>(
      {@required Route<dynamic> anchorRoute, Route<T> newRoute}) {
    return navigatorKey.currentState
        .replaceRouteBelow(anchorRoute: anchorRoute, newRoute: newRoute);
  }

  /// Pop the top-most route off the navigator.
  ///
  /// {@macro flutter.widgets.navigator.pop}
  ///
  /// {@tool sample}
  ///
  /// Typical usage for closing a route is as follows:
  ///
  /// ```dart
  /// void _handleClose() {
  ///   pop();
  /// }
  /// ```
  /// {@end-tool}
  /// {@tool sample}
  static pop([result]) {
    return navigatorKey.currentState.pop(result);
  }

  /// Whether the navigator can be popped.
  ///
  /// {@macro flutter.widgets.navigator.canPop}
  ///
  /// See also:
  ///
  ///  * [Route.isFirst], which returns true for routes for which [canPop]
  ///    returns false.
  static bool canPop() {
    return navigatorKey.currentState.canPop();
  }

}
