import 'dart:js_util';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();
Future<dynamic> navigateTo(String routeName) {
    return navigatorKey.currentState.pushNamed(routeName);
  }
bool goBack() {
    return navigatorKey.currentState.pop();
  }
}

