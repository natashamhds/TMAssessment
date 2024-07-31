import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class GlobalDualValue {
  String title;
  String value;

  GlobalDualValue({required this.title, required this.value});
}

// ignore: constant_identifier_names
const String get_choc_data = "https://mobileassessment.vercel.app/chocolate";