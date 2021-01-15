import 'package:flutter/material.dart';

class SymptomScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Colors.blue.withOpacity(0),
        // ),
        body: Container(
          margin: EdgeInsets.only(
              top: (56 / 812.0) * MediaQuery.of(context).size.height),
          decoration: BoxDecoration(color: Colors.white),
          height: MediaQuery.of(context).size.height,
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: (20 / 375.0) * MediaQuery.of(context).size.width),
              child: Column(
                children: [
                  _buildTextSymptoms(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Text _buildTextSymptoms() {
    return Text(
      'Do you have any of these symptoms?',
      style: TextStyle(
        fontSize: 31,
        fontWeight: FontWeight.w800,
        fontFamily: 'avenir',
        color: Color(0xff0d47a1),
      ),
    );
  }
}
