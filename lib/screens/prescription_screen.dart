import 'package:drFamily_app/screens/share/base_view.dart';
import 'package:drFamily_app/view_model/prescription_view_model.dart';
import 'package:drFamily_app/widgets/common/app_image.dart';
import 'package:flutter/material.dart';

class PrescrptionScreen extends StatelessWidget {
  ScrollController scrollControler = ScrollController();
  @override
  Widget build(BuildContext context) {
    return BaseView<PrescriptionViewModel>(
      builder: (context, child, model) {
        return Scaffold(
          backgroundColor: Colors.grey.shade300,
          appBar: new AppBar(
            backgroundColor: Colors.grey.shade300,
            elevation: 0,
            title: Text(
              "Presciption",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back_ios, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Container(
                  child: Image.asset(PRESCRIPTION, fit: BoxFit.cover),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              'Medicines for ',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: model.list.length,
                          itemBuilder: (context, index) => Column(
                            children: <Widget>[
                              Container(
                                decoration: new BoxDecoration(
                                  color: index % 2 == 0
                                      ? Colors.white
                                      : Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ListTile(
                                  title: Text((index + 1).toString() +
                                      ". " +
                                      model.list[index].name),
                                  subtitle: Text(
                                    ("Ngày uống: " +
                                        model.list[index].unitPerDay
                                            .toString() +
                                        ", mỗi lần: " +
                                        model.list[index].unitPerTimes
                                            .toString() +
                                        " viên / Số ngày: " +
                                        model.list[index].day.toString() +
                                        "\n" +
                                        model.list[index].note),
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  leading: SizedBox(
                                    height: 40,
                                    width: 40,
                                    child: Image.asset(
                                      index % 2 == 0
                                          ? MEDICINES_ICON1
                                          : MEDICINES_ICON2,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
