import 'package:drFamily_app/screens/landing_page/lading_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class FeedBackDialog {
  void showCustomDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            child: Container(
              height: 300,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'How Would You Rate About?',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w100),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RatingBar.builder(
                      initialRating: 3,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      glowColor: Colors.amber,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                    Container(
                      margin: EdgeInsets.all(10.0),
                      // hack textfield height
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: TextField(
                        maxLines: 3,
                        decoration: InputDecoration(
                          hintText: "Your Feedback!",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            width: 100,
                            height: 50,
                            child: Center(
                                child: Text(
                              'Cancel',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w100),
                            )),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => LandingScreen()),
                                (Route<dynamic> route) => false);
                          },
                          child: Container(
                            width: 100,
                            height: 50,
                            child: Center(
                              child: Text(
                                'Submit',
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w100),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            //   title: Text(
            //     'How Would You Rate About?',
            //     textAlign: TextAlign.center,
            //   ),
            //   actions: [

            //   ],
            //   content: Container(
            //     width: 300,
            //     height: 300,
            //     child: SingleChildScrollView(
            //       child: Column(
            //         children: [
            //           RatingBar.builder(
            //             initialRating: 3,
            //             minRating: 1,
            //             direction: Axis.horizontal,
            //             allowHalfRating: true,
            //             itemCount: 5,
            //             glowColor: Colors.amber,
            //             itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
            //             itemBuilder: (context, _) => Icon(
            //               Icons.star,
            //               color: Colors.amber,
            //             ),
            //             onRatingUpdate: (rating) {
            //               print(rating);
            //             },
            //           ),
            //         ],
            //       ),

            //     ),

            //   ),
          ),
        );
      },
    );
  }
}
