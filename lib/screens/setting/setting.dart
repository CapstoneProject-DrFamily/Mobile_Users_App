import 'package:drFamily_app/screens/setting/health_record_screen.dart';
import 'package:drFamily_app/screens/setting/profile_screen.dart';
import 'package:drFamily_app/screens/share/base_view.dart';
import 'package:drFamily_app/view_model/landing_page_vm/setting_view_model.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return BaseView<SettingViewModel>(
      builder: (context, child, model) {
        return SafeArea(
          child: Scaffold(
            body: Column(
              children: [
                model.isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.white,
                        ),
                      )
                    : _buildHeader(context, model),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      color: Colors.white,
                      child: ListTile(
                        leading: Icon(Icons.people),
                        title: Text("Dependent"),
                        trailing: Icon(Icons.keyboard_arrow_right),
                      ),
                    ),
                    Divider(
                      height: 2,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HealthRecordScreen(),
                          ),
                        );
                      },
                      child: Container(
                        color: Colors.white,
                        child: ListTile(
                          leading: Icon(EvaIcons.activityOutline),
                          title: Text("Health Record"),
                          trailing: Icon(Icons.keyboard_arrow_right),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: FlatButton(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.red),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              onPressed: () {
                                model.signOut(context);
                              },
                              child: Text(
                                'Log out',
                                style: TextStyle(color: Colors.red),
                              )),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Container _buildHeader(BuildContext context, SettingViewModel model) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildLeftSideHeader(context, model),
          _buildRightSideHeader(context, model),
        ],
      ),
    );
  }

  Expanded _buildRightSideHeader(BuildContext context, SettingViewModel model) {
    return Expanded(
      flex: 4,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              model.fullName,
              style: TextStyle(color: Colors.blue[900], fontSize: 28),
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(),
                  ),
                );
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.width * 0.08,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    'See Profile',
                    style: GoogleFonts.varelaRound(
                      fontWeight: FontWeight.normal,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Expanded _buildLeftSideHeader(BuildContext context, SettingViewModel model) {
    return Expanded(
      child: Align(
        alignment: Alignment.center,
        child: CircleAvatar(
          radius: 50.0,
          backgroundImage: NetworkImage(model.img),
        ),
      ),
      flex: 2,
    );
  }
}
