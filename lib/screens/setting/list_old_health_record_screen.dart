import 'package:drFamily_app/screens/setting/old_health_record_screen.dart';
import 'package:drFamily_app/screens/share/base_view.dart';
import 'package:drFamily_app/view_model/setting_vm/old_health_record_view_model.dart';
import 'package:drFamily_app/widgets/common/app_image.dart';
import 'package:drFamily_app/widgets/common/fonts.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListOldHealthRecordScreen extends StatelessWidget {
  final int patientID;
  ListOldHealthRecordScreen({Key key, @required this.patientID})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Old Personal Health Records",
          style: TextStyle(
            color: Colors.blue.shade300,
            fontFamily: AVENIR,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios, color: Colors.blue.shade300),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: BaseView<OldHealthRecordViewModel>(
        builder: (context, child, model) {
          return FutureBuilder(
            future: model.getListOldPersonalHealthRecord(patientID),
            builder: (context, snapshot) {
              return model.isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.white,
                      ),
                    )
                  : (model.listOldHealthRecord.length != 0)
                      ? Container(
                          child: Column(
                            children: <Widget>[
                              Flexible(
                                child: ListView.builder(
                                    itemCount: model.listOldHealthRecord.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return ListTile(
                                        title: Text("Date: " +
                                            DateFormat('dd-MM-yyyy')
                                                .format(DateTime.parse(model
                                                    .listOldHealthRecord[index]
                                                    .insDatetime))
                                                .toString()),
                                        subtitle: Text("Created by: " +
                                            model.listOldHealthRecord[index]
                                                .insBy),
                                        trailing: IconButton(
                                          icon: Icon(Icons.chevron_right),
                                          onPressed: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  OldHealthRecordScreen(
                                                healthRecordID: model
                                                    .listOldHealthRecord[index]
                                                    .healthRecordID,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            ],
                          ),
                        )
                      : Container(
                          child: Column(
                            children: <Widget>[
                              Center(
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  margin: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height /
                                        3.5,
                                    bottom: 20.0,
                                  ),
                                  child: Image.asset(
                                    PHR_ICON,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Text(
                                "You don't have any old Personal Health Record",
                              ),
                            ],
                          ),
                        );
            },
          );
        },
      ),
    );
  }
}
