import 'package:drFamily_app/screens/setting/health_record_screen.dart';
import 'package:drFamily_app/screens/setting/profile_screen.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            _buildHeader(context),
            Flexible(
              child: SettingsList(
                sections: [
                  SettingsSection(
                    title: 'Common',
                    tiles: [
                      SettingsTile(
                        title: 'Dependent',
                        leading: Icon(Icons.people),
                      ),
                      SettingsTile(
                        title: 'HealthRecord',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HealthRecordScreen(),
                            ),
                          );
                        },
                        leading: Icon(EvaIcons.activityOutline),
                      ),
                    ],
                  ),
                  SettingsSection(
                    title: 'Account',
                    tiles: [
                      SettingsTile(
                          title: 'Sign out', leading: Icon(Icons.exit_to_app)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _buildHeader(BuildContext context) {
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
          _buildLeftSideHeader(),
          _buildRightSideHeader(context),
        ],
      ),
    );
  }

  Expanded _buildRightSideHeader(BuildContext context) {
    return Expanded(
      flex: 4,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hoang Duc',
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

  Expanded _buildLeftSideHeader() {
    return Expanded(
      child: CircleAvatar(
        radius: 50,
        backgroundColor: Colors.blue,
        child: ClipOval(
          child: SizedBox(
            width: 180,
            height: 180,
            child: Center(
              child: Text(
                'HD',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
      flex: 2,
    );
  }
}
