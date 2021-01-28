import 'package:drFamily_app/widgets/common/fonts.dart';
import 'package:flutter/material.dart';

class HealthRecordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Personal Health Record",
            style: TextStyle(
              color: Colors.black,
              fontFamily: AVENIR,
            ),
          ),
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          bottom: TabBar(
            unselectedLabelColor: Colors.black,
            labelColor: Colors.blue[400],
            // indicator: BoxDecoration(
            //   borderRadius: BorderRadius.circular(50),
            //   color: Colors.redAccent,
            // ),
            tabs: [
              Tab(
                child: Text(
                  "Tiền sử & Dị ứng",
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: AVENIR,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  "Yếu tố tiếp xúc",
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: AVENIR,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            TabView1(),
            Icon(Icons.movie),
          ],
        ),
      ),
    );
  }
}

class TabView1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.white,
          title: TabBar(
            unselectedLabelColor: Colors.red,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.redAccent,
            ),
            tabs: [
              Tab(text: "Tình trạng lúc sinh"),
              Tab(text: "Tiền sử bệnh tật, dị ứng"),
            ],
          ),
        ),
      ),
    );
  }
}
