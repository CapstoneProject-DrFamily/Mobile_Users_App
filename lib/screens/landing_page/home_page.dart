import 'package:drFamily_app/screens/home/find_doctor/list_doctor_page.dart';
import 'package:drFamily_app/screens/home/find_doctor/symptom_page.dart';
import 'package:drFamily_app/widgets/common/app_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF9F9F9),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: CustomPaint(
                  painter: PathPainterTop(),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: CustomPaint(
                  painter: PathPainterBottom(),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: CustomPaint(
                  painter: PathPainterRight(),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.92,
                child: SingleChildScrollView(
                  child: _buildBody(context),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Padding _buildBody(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, top: 45),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Welcome user \nyour Health is our Mission',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              fontFamily: 'avenir',
              color: Color(0xff0d47a1),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          Container(
            child: Stack(
              children: [
                Opacity(
                  opacity: 0.6,
                  child: Container(
                    margin: EdgeInsets.only(top: 60),
                    height: MediaQuery.of(context).size.height * 0.86,
                    decoration: BoxDecoration(
                      color: Color(0xFFF1EFF1),
                      borderRadius: BorderRadius.all(
                        Radius.circular(40),
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    GestureDetector(
                      child: _buildDoctorFunction(
                          context, 'Find a Doctor', FIND_DOCTOR, 150, 190),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (_) => new AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30))),
                                  title:
                                      Center(child: new Text("Choose patient")),
                                  content: new Container(
                                    height:
                                        300.0, // Change as per your requirement
                                    width:
                                        300.0, // Change as per your requirement
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          ListView.builder(
                                            primary: false,
                                            shrinkWrap: true,
                                            itemCount: 5,
                                            itemBuilder: (context, index) =>
                                                Row(
                                              children: [
                                                Expanded(
                                                  child: Card(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              40),
                                                    ),
                                                    child: InkWell(
                                                      onTap: () {
                                                        print('Card tapped.');
                                                      },
                                                      child: Container(
                                                          child: Row(
                                                        children: [
                                                          Expanded(
                                                            flex: 3,
                                                            child: ListTile(
                                                              leading: Icon(
                                                                Icons
                                                                    .account_circle,
                                                                size: 50,
                                                              ),
                                                              title: Text(
                                                                  'Anh Khoa'),
                                                              subtitle: Text(
                                                                  'Friend'),
                                                            ),
                                                          ),
                                                          // Expanded(
                                                          //     child: new Radio(
                                                          //   value: 0,
                                                          // )),
                                                        ],
                                                      )),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          ClipOval(
                                            child: Material(
                                              color: Colors
                                                  .grey[350], // button color
                                              child: InkWell(
                                                splashColor: Colors
                                                    .cyan, // inkwell color
                                                child: SizedBox(
                                                    width: 56,
                                                    height: 56,
                                                    child: Icon(Icons.add)),
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ListDoctorPage()),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text('Cancel'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: Text('Next'),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SymptomScreen()),
                                        );
                                      },
                                    ),
                                  ],
                                ));
                      },
                    ),
                    _buildDoctorFunction(context, 'Book Appointment',
                        BOOK_APPOINTMENT, 130, 170),
                    _buildDoctorFunction(
                        context, 'Your own Doctor', YOUR_DOCTOR, 140, 180),
                    _buildDoctorFunction(context, 'Medicine Schedule',
                        MEDICINE_SCHEDULE, 140, 180),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _buildDoctorFunction(BuildContext context, String title,
      String icon, double height, double width) {
    return Container(
      height: 160,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20 / 2),
      // color: Colors.blueAccent,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: 136,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              color: Color(0xFF40BAD5),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 15),
                  blurRadius: 27,
                  color: Colors.black12,
                ),
              ],
            ),
            child: Container(
              margin: EdgeInsets.only(right: 7),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
              ),
            ),
          ),
          // our function image
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: height,
              width: width,
              child: Image.asset(
                icon,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: SizedBox(
              height: 136,
              width: MediaQuery.of(context).size.width - 220,
              child: Column(
                children: [
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      title,
                      style: TextStyle(
                          fontFamily: 'avenir',
                          fontSize: 22.5,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff0d47a1)),
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class PathPainterBottom extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Color(0xffcef4e8);
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
    return true;
  }
}

class PathPainterTop extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = new Paint();
    paint.color = Color(0xFFBBDEFB);

    Path path = new Path();
    path.moveTo(0, 0);
    path.lineTo(size.width * 0.3, 0);
    path.quadraticBezierTo(size.width * 0.5, size.height * 0.03,
        size.width * 0.42, size.height * 0.17);
    path.quadraticBezierTo(
        size.width * 0.35, size.height * 0.32, 0, size.height * 0.29);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class PathPainterRight extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = new Paint();
    paint.color = Color(0xFFFFE0B2);

    Path path = new Path();
    path.moveTo(size.width, 0);
    path.lineTo(size.width * 0.7, 0);
    path.quadraticBezierTo(size.width * 0.5, size.height * 0.03,
        size.width * 0.55, size.height * 0.23);
    path.quadraticBezierTo(
        size.width * 0.65, size.height * 0.5, size.width, size.height * 0.6);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
