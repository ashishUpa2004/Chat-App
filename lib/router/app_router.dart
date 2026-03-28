import 'package:flutter/material.dart';

class AppRouter {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState? get _navigator => navigatorKey.currentState;// error was here, it was returning null because navigatorKey was not set in MaterialApp

  void pop<T>([T? result]) {
    _navigator?.pop(result);
  }

  Future<T?> push<T>(Widget page) {
    return _navigator?.push<T>(
      MaterialPageRoute(builder: (_) => page),
    ) ?? Future.value(null);
  }

  Future<T?> pushReplacement<T>(Widget page) {
    return _navigator?.pushReplacement<T, dynamic>(
      MaterialPageRoute(builder: (_) => page),
    ) ?? Future.value(null);
  }

  Future<T?> pushAndRemoveUntil<T>(Widget page) {
    return _navigator?.pushAndRemoveUntil<T>(
      MaterialPageRoute(builder: (_) => page),
      (route) => false,
    ) ?? Future.value(null);
  }

  Future<T?> pushNamed<T>(String routeName, {Object? arguments}) {
    return _navigator?.pushNamed<T>(
      routeName,
      arguments: arguments,
    ) ?? Future.value(null);
  }
}