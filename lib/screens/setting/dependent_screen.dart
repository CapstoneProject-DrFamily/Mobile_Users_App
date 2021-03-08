import 'package:drFamily_app/screens/share/base_view.dart';
import 'package:drFamily_app/view_model/setting_vm/dependent_view_model.dart';
import 'package:drFamily_app/widgets/common/app_image.dart';
import 'package:drFamily_app/widgets/common/fonts.dart';
import 'package:flutter/material.dart';

class DependentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Dependent",
          style: TextStyle(
            color: Colors.black,
            fontFamily: AVENIR,
          ),
        ),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: BaseView<DependentViewModel>(
        builder: (context, child, model) {
          return SingleChildScrollView(
            child: Container(
              child: Column(
                children: <Widget>[
                  Center(
                    child: Container(
                      height: 100,
                      width: 100,
                      margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 3.5,
                        bottom: 20.0,
                      ),
                      child: Image.asset(
                        DEPENDENT_ICON,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Text(
                    "You don't have any dependent",
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height / 14,
                      decoration: new BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Add dependent",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
