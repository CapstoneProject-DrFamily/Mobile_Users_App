import 'package:drFamily_app/screens/home/find_doctor/symptom_page.dart';
import 'package:drFamily_app/screens/landing_page/home_page.dart';
import 'package:drFamily_app/screens/landing_page/lading_page.dart';
import 'package:drFamily_app/screens/login/login_demo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  //render
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SymptomScreen(),
    );
  }
}

// class LandingPage extends StatefulWidget {
//   @override
//   _LandingPageState createState() => _LandingPageState();
// }

// class _LandingPageState extends State<LandingPage> {
//   //For switch page bottom navigation
//   int _currentPage = 0;
//   final List<Widget> _children = [
//     HomePage(),
//     SettingPage(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       body: _children[_currentPage],
//       bottomNavigationBar: FancyBottomNavigation(
//           tabs: [
//             TabData(iconData: Icons.home, title: "Home"),
//             TabData(
//                 iconData: Icons.settings,
//                 title: "Setting",
//                 onclick: () => Navigator.of(context).push(
//                     MaterialPageRoute(builder: (context) => SettingPage()))),
//           ],
//           initialSelection: 0,
//           onTabChangedListener: (position) {
//             setState(() {
//               _currentPage = position;
//             });
//           }),
//     );
//   }
// }
