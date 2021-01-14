import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:drFamily_app/screens/share/base_view.dart';
import 'package:drFamily_app/view_model/landing_page_vm/landing_page_view_model.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<LandingPageViewModel>(
      builder: (context, child, model) {
        return Scaffold(
          extendBody: true,
          // resizeToAvoidBottomInset: false,
          // resizeToAvoidBottomPadding: false,
          body: PageView(
            controller: model.pageController,
            onPageChanged: (index) {
              model.changeTab(index);
            },
            children: [
              model.page[0],
              model.page[1],
              model.page[2],
              model.page[3],
            ],
          ),

          bottomNavigationBar: BottomNavyBar(
            selectedIndex: model.currentIndex,
            showElevation: true,
            onItemSelected: (index) {
              print(index);
              model.changeTab(index);
              model.pageController.jumpToPage(index);
            },
            items: [
              model.listItem[0],
              model.listItem[1],
              model.listItem[2],
              model.listItem[3],
            ],
          ),
        );
      },
    );
  }
}
