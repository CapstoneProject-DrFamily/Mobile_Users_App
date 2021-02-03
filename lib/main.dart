import 'package:drFamily_app/screens/landing_page/lading_page.dart';
import 'package:drFamily_app/screens/login/login_page.dart';
import 'package:drFamily_app/screens/share/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  var profileID = prefs.getInt('usProfileID');

  await setupLocator();

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: profileID == null ? LoginScreen() : LandingScreen(),
    ),
  );
}
