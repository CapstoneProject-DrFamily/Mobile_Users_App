import 'package:drFamily_app/themes/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddDependentProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: new AppBar(
        backgroundColor: MainColors.blueEnd,
        centerTitle: true,
        elevation: 0,
        title: new Text(
          "ADD PEOPLE",
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 1.25,
              color: MainColors.blueEnd,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      top: 30.0,
                      left: 40.0,
                      right: 40.0,
                    ),
                    child: Text(
                      "Adding a profile for a family member will help us serve you better",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 40.0,
                    ),
                    child: Container(
                      height: 1.0,
                      width: 70.0,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 40.0,
                    ),
                    child: Text(
                      "WHO DO YOU WANT TO ADD?",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 30.0,
                      right: 270.0,
                    ),
                    child: Text(
                      "Full name",
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 10.0,
                      left: 30.0,
                      right: 20.0,
                      // right: 270.0,
                    ),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.none,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Enter full name...',
                        hintStyle: TextStyle(
                          color: MainColors.hintTextColor,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 20.0,
                      right: 290.0,
                    ),
                    child: Text(
                      "Phone",
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 10.0,
                      left: 30.0,
                      right: 20.0,
                      // right: 270.0,
                    ),
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      textCapitalization: TextCapitalization.none,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Enter phone..',
                        hintStyle: TextStyle(
                          color: MainColors.hintTextColor,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 20.0,
                      right: 195.0,
                    ),
                    child: Text(
                      "Relationship with you",
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 10.0,
                      left: 30.0,
                      right: 20.0,
                    ),
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      textCapitalization: TextCapitalization.none,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Choose relationship',
                        hintStyle: TextStyle(
                          color: MainColors.hintTextColor,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 50,
              margin: const EdgeInsets.only(
                top: 8.0,
                left: 70.0,
                right: 70.0,
              ),
              child: RaisedButton(
                color: MainColors.riseButtonBlue,
                onPressed: () {},
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'NEXT',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // Widget _bodyWidget() {
  //   return Container(
  //     child: Column(
  //       children: [
  //         Container(
  //           height: MediaQuery.of(context).
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
