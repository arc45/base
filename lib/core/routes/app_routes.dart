import 'package:flutter/material.dart';
import 'package:base_project/views/splash_view/splash_view.dart';

class AppRoutes {
  static const String initialRoute = '/';

  static Map<String, WidgetBuilder> get routes => {
    initialRoute: SplashView.builder,
  };
}
