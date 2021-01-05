import 'package:drFamily_app/screens/share/base_view.dart';
import 'package:drFamily_app/view_model/landing_view_model.dart';
import 'package:drFamily_app/widgets/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<LandingViewModel>(
      builder: (context, child, model) => Scaffold(
        body: model.page[model.indexPage],
        bottomNavigationBar: FancyBottomNavigation(
            tabs: [
              TabData(iconData: Icons.home, title: "Home"),
              TabData(
                iconData: Icons.settings,
                title: "Setting",
                // onclick: () => Navigator.of(context).push(
                //   MaterialPageRoute(builder: (context) => SettingPage()),
                // ),
              ),
            ],
            initialSelection: 0,
            onTabChangedListener: (position) {
              model.changePage(position);
            }),
      ),
    );
  }
}
