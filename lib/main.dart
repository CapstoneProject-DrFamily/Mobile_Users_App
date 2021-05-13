import 'package:drFamily_app/screens/checkout_screen.dart';
import 'package:drFamily_app/screens/landing_page/lading_page.dart';
import 'package:drFamily_app/screens/login/login_page.dart';
import 'package:drFamily_app/screens/login/signup_screen.dart';
import 'package:drFamily_app/screens/share/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  //check
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  var profileID = prefs.getInt('usProfileID');

  await setupLocator();

  runApp(GetMaterialApp(
    theme: ThemeData(fontFamily: 'VarelaRound'),
    debugShowCheckedModeBanner: false,
    home:
        // CheckOutScreen(
        //     transactionId: 'TS-05845786-c0e8-4b64-a322-9bd535ca55f6'),
        (profileID == 0 || profileID == null) ? LoginScreen() : LandingScreen(),
  ));
}
