import 'package:drFamily_app/screens/doctor_detail_page.dart';
import 'package:drFamily_app/themes/colors.dart';
import 'package:drFamily_app/view_model/search_page_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'share/base_view.dart';

class SearchPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return BaseView<SearchPageViewModel>(
      builder: (context, child, model) {
        return Scaffold(
          backgroundColor: MainColors.kMainBody,
          appBar: AppBar(
            backgroundColor: MainColors.blueBegin,
            centerTitle: true,
            title: Text('List of Actor participated'),
            elevation: 0,
          ),
          body: Container(
            color: MainColors.blueBegin,
            // decoration: BoxDecoration(
            //   gradient: LinearGradient(
            //     begin: Alignment(-1.0, 0.0),
            //     end: Alignment(5, 0.0),
            //     colors: [MainColors.blueBegin, MainColors.blueEnd],
            //   ),
            // ),
            child: FutureBuilder(
                future: model.loadDoctor(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: Text("This scenario don't have any actor"),
                      );
                    } else
                      return Container(
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                child: ListView.builder(
                                    itemCount: model.listDoctor.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return new GestureDetector(
                                        child: new ListTile(
                                            title: new Card(
                                                child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            new ListTile(
                                              leading: CircleAvatar(
                                                // backgroundColor:
                                                //     MainColors.blueBegin,
                                                radius: 45,
                                                // child: ClipOval(
                                                //   child: Image.network(
                                                //     model.listDoctor[index].url,
                                                //     width: 60,
                                                //     height: 60,
                                                //   ),
                                                // ),
                                              ),
                                              title: Text(
                                                model.listDoctor[index].name,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              subtitle: Text("Speciality : " +
                                                  model.listDoctor[index]
                                                      .speciality),
                                            ),
                                          ],
                                        ))),
                                        onTap: () async {
                                          final created = await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DoctorDetailPage(
                                                        id: model
                                                            .listDoctor[index]
                                                            .id)),
                                          );
                                        },
                                      );
                                    }),
                              ),
                            ),
                          ],
                        ),
                      );
                  } else
                    return Center(
                        child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                    ));
                }),
          ),
        );
      },
    );
  }
}
