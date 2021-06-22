import 'package:flutter/material.dart';
import 'package:payflow/modules/home/HomePage.dart';
import 'package:payflow/modules/login/LoginPage.dart';
import 'package:payflow/modules/splash/SplashPage.dart';
import 'package:payflow/shared/themes/AppColors.dart';

void main() {
  runApp(AppWidget());
}

class AppWidget extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pay Flow',
      theme: ThemeData(
        primaryColor: AppColors.primary,
      ),
      //home: SplashPage(),
      home: HomePage(),
    );
  }
}
