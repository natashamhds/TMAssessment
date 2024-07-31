import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tm_assessment/constant/config.dart';
import 'package:tm_assessment/constant/routes.dart';
import 'package:tm_assessment/services/service_locator.dart';
import 'package:tm_assessment/view/welcome_screen.dart';

void main() async {
  await setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child: MaterialApp(
        navigatorKey: navigatorKey,
        // title: 'TM Assessment',
        theme: ThemeData(
          useMaterial3: false,
          appBarTheme: Platform.isIOS ? const AppBarTheme(centerTitle: false, systemOverlayStyle: SystemUiOverlayStyle.dark) : Platform.isAndroid ? const AppBarTheme(centerTitle: false, systemOverlayStyle: SystemUiOverlayStyle.dark) : const AppBarTheme(centerTitle: false, systemOverlayStyle: SystemUiOverlayStyle.dark),
        ),
        debugShowCheckedModeBanner: false,
        routes: AppRoutes.getRoutes(),
        initialRoute: "/",
        // builder: (context, widget) {
        //   return MediaQuery(data: data, child: child)
        // },
        home: const WelcomeScreen(),
      ),
    );
  }
}
