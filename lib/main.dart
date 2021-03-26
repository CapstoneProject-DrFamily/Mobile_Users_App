import 'package:drFamily_app/screens/landing_page/lading_page.dart';
import 'package:drFamily_app/screens/login/login_page.dart';
import 'package:drFamily_app/screens/prescription_screen.dart';
import 'package:drFamily_app/screens/share/service_locator.dart';
import 'package:drFamily_app/screens/transaction/transaction_base_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:drFamily_app/screens/test/test.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  var profileID = prefs.getInt('usProfileID');

  await setupLocator();

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: (profileID == 0 || profileID == null)
          ? LoginScreen()
          : LandingScreen(),
      // home: SignUpScreen(),
      // home: TransactionBaseScreen(
      //   transactionId: 'TS-a093b19b-95b4-4c38-a3f5-4da3467caa7b',
      // ),
    ),
  );
}
