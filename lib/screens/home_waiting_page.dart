import 'package:drFamily_app/Helper/fire_base_link.dart';
import 'package:drFamily_app/themes/colors.dart';
import 'package:flutter/material.dart';

class HomeWaitingPage extends StatelessWidget {
  final List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.indigo,
    Colors.pinkAccent,
    Colors.blue
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bodyWidget(),
    );
  }

  Widget _bodyWidget() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(-1.0, 0.0),
          end: Alignment(1.0, 0.0),
          colors: [MainColors.blueBegin, MainColors.blueEnd],
        ),
      ),
      child: Center(
        child: Image.network(
          ImagesLinks.wordLogoLink,
          width: 250.0,
          height: 150.0,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
