import 'package:drFamily_app/Helper/fire_base_link.dart';
import 'package:drFamily_app/screens/search_page.dart';
import 'package:drFamily_app/themes/colors.dart';
import 'package:flutter/material.dart';

class TypeOfBookDrPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: MainColors.blueEnd,
        centerTitle: true,
        elevation: 0,
        title: new Text(
          "WHAT DO YOU NEED?",
        ),
      ),
      body: Container(
        color: MainColors.blueEnd,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 150,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchPage()),
                );
              },
              child: Container(
                height: 150,
                child: new Card(
                  elevation: 10,
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Container(
                          width: 100.0,
                          height: 100.0,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              image: new DecorationImage(
                                image:
                                    NetworkImage(ImagesLinks.symptomIconLink),
                                fit: BoxFit.cover,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(75.0)),
                              boxShadow: [
                                BoxShadow(blurRadius: 7.0, color: Colors.black)
                              ]),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Container(
                          child: Text(
                            "Find Doctors by symptom",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchPage()),
                );
              },
              child: Container(
                height: 150,
                child: new Card(
                  elevation: 10,
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Container(
                          width: 100.0,
                          height: 100.0,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              image: new DecorationImage(
                                image: NetworkImage(
                                    ImagesLinks.specialistIconLink),
                                fit: BoxFit.cover,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(75.0)),
                              boxShadow: [
                                BoxShadow(blurRadius: 7.0, color: Colors.black)
                              ]),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Container(
                          child: Text(
                            "Find Doctors by specialist",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bodyWidget() {
    return Container(
      color: MainColors.blueEnd,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 150,
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              height: 150,
              child: new Card(
                elevation: 10,
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Container(
                        width: 100.0,
                        height: 100.0,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            image: new DecorationImage(
                              image: NetworkImage(ImagesLinks.symptomIconLink),
                              fit: BoxFit.cover,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(75.0)),
                            boxShadow: [
                              BoxShadow(blurRadius: 7.0, color: Colors.black)
                            ]),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Container(
                        child: Text(
                          "Find Doctors by symptom",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              height: 150,
              child: new Card(
                elevation: 10,
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Container(
                        width: 100.0,
                        height: 100.0,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            image: new DecorationImage(
                              image:
                                  NetworkImage(ImagesLinks.specialistIconLink),
                              fit: BoxFit.cover,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(75.0)),
                            boxShadow: [
                              BoxShadow(blurRadius: 7.0, color: Colors.black)
                            ]),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Container(
                        child: Text(
                          "Find Doctors by specialist",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
