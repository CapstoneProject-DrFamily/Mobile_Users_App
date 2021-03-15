import 'package:drFamily_app/screens/share/base_view.dart';
import 'package:drFamily_app/view_model/rating_vm/rating_base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingBaseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<RatingBaseViewModel>(builder: (context, child, model) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(Icons.clear, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Expanded(
                      child: Center(
                          child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      model.text,
                      style: TextStyle(fontSize: 20),
                    ),
                  ))),
                  Expanded(
                    flex: 2,
                    child: RatingBar.builder(
                      initialRating: model.rating,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: false,
                      itemCount: 5,
                      glowColor: Colors.amber,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        model.changeRating(rating);
                      },
                    ),
                  ),
                ],
              ),
              Divider(
                thickness: 1,
                endIndent: 50,
                indent: 50,
              ),
              Text(model.textHint),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ActionChip(
                            backgroundColor: model.list.contains("Punctuality")
                                ? Colors.blue
                                : null,
                            onPressed: () {
                              model.addNote("Punctuality");
                            },
                            elevation: 5,
                            label: Text(
                              'Punctuality',
                              style: TextStyle(
                                color: model.list.contains("Punctuality")
                                    ? Colors.white
                                    : null,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ActionChip(
                            backgroundColor: model.list.contains("Attitude")
                                ? Colors.blue
                                : null,
                            onPressed: () {
                              model.addNote("Attitude");
                            },
                            elevation: 5,
                            label: Text(
                              'Attitude',
                              style: TextStyle(
                                color: model.list.contains("Attitude")
                                    ? Colors.white
                                    : null,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ActionChip(
                            backgroundColor:
                                model.list.contains("Specialist skill")
                                    ? Colors.blue
                                    : null,
                            onPressed: () {
                              model.addNote("Specialist skill");
                            },
                            elevation: 5,
                            label: Text(
                              'Specialist skill',
                              style: TextStyle(
                                color: model.list.contains("Specialist skill")
                                    ? Colors.white
                                    : null,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ActionChip(
                            backgroundColor:
                                model.list.contains("Professionalism")
                                    ? Colors.blue
                                    : null,
                            onPressed: () {
                              model.addNote("Professionalism");
                            },
                            elevation: 5,
                            label: Text(
                              'Professionalism',
                              style: TextStyle(
                                color: model.list.contains("Professionalism")
                                    ? Colors.white
                                    : null,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ActionChip(
                            backgroundColor: model.list.contains("Price")
                                ? Colors.blue
                                : null,
                            onPressed: () {
                              model.addNote("Price");
                            },
                            elevation: 5,
                            label: Text(
                              'Price',
                              style: TextStyle(
                                color: model.list.contains("Price")
                                    ? Colors.white
                                    : null,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    TextFormField(
                      onChanged: (value) {
                        model.other = value;
                      },
                      decoration: InputDecoration(hintText: 'Other (Optional)'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.all(20),
          child: FloatingActionButton.extended(
            onPressed: () {
              model.rateService();
            },
            label: const Text('Rate'),
            icon: const Icon(Icons.thumb_up),
            backgroundColor: Colors.blue,
          ),
        ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );
    });
  }
}
