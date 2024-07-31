import 'package:flutter/material.dart';
import 'package:tm_assessment/view/Home%20Screen/home_screen.dart';
import 'package:tm_assessment/view/welcome_screen.dart';

class AppRoutes {
  static String welcome = "/welcome";
  static String home = "/home";
  static String report = "/report";

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      welcome: (BuildContext context) => const WelcomeScreen(),
      home: (BuildContext context) => const HomeScreen(),
      // report: (BuildContext context) => WelcomeScreen(),
    };
  }
}