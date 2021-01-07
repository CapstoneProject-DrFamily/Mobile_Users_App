import 'package:drFamily_app/themes/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddDependentProfilePage extends StatelessWidget {
  List<String> _relationshipList = [
    'Father',
    'Mother',
    'Grandmother',
    'Grandfather',
    'Sister',
    'Brother'
  ];
  String _selectedRelationship;

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
                  _fullNameField(),
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
                  _phoneField(),
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
                  _relationshipField(),
                ],
              ),
            ),
            Container(
              height: 50.0,
              width: 300.0,
              margin: const EdgeInsets.only(
                top: 8.0,
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

  Widget _fullNameField() {
    return Container(
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
    );
  }

  Widget _phoneField() {
    return Container(
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
    );
  }

  Widget _relationshipField() {
    return Container(
      margin: const EdgeInsets.only(
        top: 10.0,
        left: 30.0,
        right: 20.0,
      ),
      width: 340.0,
      height: 55.0,
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: MainColors.white,
      ),
      child: Container(
        margin: const EdgeInsets.only(
          left: 12.0,
          top: 2.0,
        ),
        child: DropdownButton(
          elevation: 16,
          iconSize: 28,
          hint: Text(
            'Please choose relationship',
            style: TextStyle(fontSize: 16),
          ),
          isExpanded: true,
          value: _selectedRelationship,
          items: _relationshipList.map((relationship) {
            return DropdownMenuItem(
              child: new Text(relationship),
              value: relationship,
            );
          }).toList(),
          onChanged: (String newValue) {
            _selectedRelationship = newValue;
          },
        ),
      ),
    );
  }
}
