import 'package:drFamily_app/Helper/helper_method.dart';
import 'package:drFamily_app/screens/share/base_view.dart';
import 'package:drFamily_app/view_model/transaction_vm/awaiting_sample_view_model.dart';
import 'package:drFamily_app/widgets/common/app_image.dart';
import 'package:flutter/material.dart';

class AwaitingSampleScreen extends StatelessWidget {
  final String transactionID;
  AwaitingSampleScreen({@required this.transactionID});
  @override
  Widget build(BuildContext context) {
    return BaseView<AwaitingSampleViewModel>(
      builder: (context, child, model) {
        return FutureBuilder(
          future: model.fetchData(transactionID),
          builder: (context, snapshot) {
            if (model.isLoading) {
              return Container(
                color: Colors.white,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              return Scaffold(
                  body: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: CustomPaint(
                          painter: pathPainter(),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(50),
                        margin: EdgeInsets.only(top: 50),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "This transaction has been temporarily paused.",
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            Text(
                              "Waiting for test results",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: MediaQuery.of(context).size.height * 0.3,
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: Image.asset(ON_BOARD),
                            )),
                      ),
                      // Positioned(
                      //   bottom: 0,
                      //   right: 0,
                      //   child: InkWell(
                      //     child: Container(
                      //       padding: EdgeInsets.only(left: 10, right: 10),
                      //       height: 80,
                      //       decoration: BoxDecoration(
                      //           gradient: LinearGradient(
                      //             stops: [0, 1],
                      //             colors: [MainColors.blueBegin, MainColors.blueEnd],
                      //           ),
                      //           borderRadius: BorderRadius.only(
                      //             topLeft: Radius.circular(25),
                      //           )),
                      //       child: Center(
                      //         child: Text(
                      //           "Continue checking",
                      //           style: TextStyle(
                      //             color: Colors.white,
                      //             fontSize: 20,
                      //             fontWeight: FontWeight.w800,
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //     onTap: () {
                      //       model.continueChecking(context);
                      //     },
                      //   ),
                      // ),

                      Positioned(
                        top: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: AppBar(
                          leading: new IconButton(
                            icon: new Icon(Icons.arrow_back_ios,
                                color: Colors.black),
                            onPressed: () {
                              HelperMethod
                                  .disableupdateDoctorTransactionSample();
                              Navigator.of(context).pop();
                            },
                          ),
                          backgroundColor: Colors.blue
                              .withOpacity(0), //You can make this transparent
                          elevation: 0.0, //No shadow
                        ),
                      ),
                    ],
                  ),
                ],
              )
                  // Container(
                  //   decoration: BoxDecoration(
                  //       image: DecorationImage(
                  //           image: AssetImage("assets/onBoardDoc.png"))),
                  //   child: Center(
                  //     child: Text('sa'),
                  //   ),
                  // ),
                  );
            }
          },
        );
      },
    );
  }
}

class pathPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Color(0xff0d47a1).withOpacity(0.3);
    paint.style = PaintingStyle.fill;
    var path = Path();
    path.moveTo(0, size.height * 0.4);
    path.quadraticBezierTo(size.width * 0.35, size.height * 0.40,
        size.width * 0.58, size.height * 0.6);
    path.quadraticBezierTo(size.width * 0.72, size.height * 0.8,
        size.width * 0.92, size.height * 0.8);
    path.quadraticBezierTo(
        size.width * 0.98, size.height * 0.8, size.width, size.height * 0.82);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
