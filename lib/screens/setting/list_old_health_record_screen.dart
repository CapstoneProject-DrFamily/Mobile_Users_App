import 'package:drFamily_app/screens/setting/old_health_record_screen.dart';
import 'package:drFamily_app/screens/share/base_view.dart';
import 'package:drFamily_app/view_model/setting_vm/old_health_record_view_model.dart';
import 'package:drFamily_app/widgets/common/fonts.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListOldHealthRecordScreen extends StatelessWidget {
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
          return model.isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  ),
                )
              : Container(
                  child: Column(
                    children: <Widget>[
                      Flexible(
                        child: ListView.builder(
                            itemCount: model.listOldHealthRecord.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                title: Text("Date: " +
                                    DateFormat('dd-MM-yyyy')
                                        .format(DateTime.parse(model
                                            .listOldHealthRecord[index]
                                            .insDatetime))
                                        .toString()),
                                subtitle: Text("Created by: " +
                                    model.listOldHealthRecord[index].insBy),
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
                );
        },
      ),
    );
  }
}
