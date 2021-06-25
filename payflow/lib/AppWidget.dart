import 'package:flutter/material.dart';
import 'package:payflow/modules/home/HomePage.dart';
import 'package:payflow/modules/splash/SplashPage.dart';

//import 'modules/home/HomePage.dart';
import 'modules/login/LoginPage.dart';
import 'shared/themes/AppColors.dart';

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
      //home: HomePage(),
      //home: LoginPage(),
      initialRoute: "/splash",
      routes: {
        "/home": (context) => HomePage(),
        "/login": (context) => LoginPage(),
        "/splash": (context) => SplashPage(),
      },
    );
  }
}
