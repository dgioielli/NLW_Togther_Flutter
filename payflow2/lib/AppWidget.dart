import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:payflow/modules/accountsManager/AccountEditPage.dart';
import 'package:payflow/modules/accountsManager/AccountsPage.dart';
import 'package:payflow/modules/barcodeSacnner/BarcodeScannerPage.dart';
import 'package:payflow/modules/home/HomePage.dart';
import 'package:payflow/modules/insertBoleto/InsertBoletoPage.dart';
import 'package:payflow/modules/splash/SplashPage.dart';
import 'package:payflow/shared/keys/RouteKeys.dart';
import 'package:payflow/shared/models/UserModel.dart';

//import 'modules/home/HomePage.dart';
import 'modules/login/LoginPage.dart';
import 'shared/themes/AppColors.dart';

class AppWidget extends StatelessWidget {
  AppWidget() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pay Flow',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: AppColors.primary,
      ),
      //home: SplashPage(),
      //home: HomePage(),
      //home: LoginPage(),
      initialRoute: RouteKeys.accounts,
      routes: {
        RouteKeys.home: (context) => HomePage(
              user: ModalRoute.of(context)!.settings.arguments as UserModel,
            ),
        //RouteKeys.home: (context) => TabBarDemo(),
        RouteKeys.login: (context) => LoginPage(),
        RouteKeys.splash: (context) => SplashPage(),
        RouteKeys.barcode_scanner: (context) => BarcodeScannerPage(),
        RouteKeys.insert_boleto: (context) => InsertBoletoPage(
              barcode: ModalRoute.of(context) != null
                  ? ModalRoute.of(context)!.settings.arguments.toString()
                  : null,
            ),
        RouteKeys.accounts: (context) => AccountsPage(),
        RouteKeys.accounts_edit: (context) => AccountEditPage(),
      },
    );
  }
}
