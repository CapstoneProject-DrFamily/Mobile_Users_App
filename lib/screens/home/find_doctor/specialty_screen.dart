import 'package:drFamily_app/screens/home/find_doctor/list_doctor_page.dart';
import 'package:drFamily_app/screens/share/base_view.dart';
import 'package:drFamily_app/view_model/home_vm/find_doctor_vm/specialty_screen_view_model.dart';
import 'package:drFamily_app/widgets/common/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SpecialtyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseView<SpecialtyScreenViewModel>(
        builder: (context, child, model) {
          return Stack(
            children: [
              //backgroud color
              Positioned(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Color.fromRGBO(121, 199, 153, 1),
                      Color.fromRGBO(73, 167, 157, 1)
                    ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                  ),
                ),
              ),
              //main text
              Positioned(
                top: 70,
                left: 16,
                right: 16,
                child: SafeArea(
                  top: true,
                  left: true,
                  right: true,
                  child: Container(
                    height: 48,
                    child: Text(
                      'Choose Doctor by Specialty',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              //back buttom
              Positioned(
                top: 0.0,
                left: 0.0,
                right: 0.0,
                child: AppBar(
                  title: Text(''), // You can add title here
                  leading: new IconButton(
                    icon: new Icon(Icons.arrow_back_ios, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  backgroundColor: Colors.blue
                      .withOpacity(0), //You can make this transparent
                  elevation: 0.0, //No shadow
                ),
              ),
              //body content
              Positioned(
                top: 150,
                left: 16,
                right: 16,
                child: SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: model.isLoading
                        ? Center(
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.white,
                            ),
                          )
                        : _buildListCard(model),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }

  Container _buildListCard(SpecialtyScreenViewModel model) {
    return Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: model.listSpecialty.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ListDoctorPage()),
              );
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 8.0,
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              child: InkWell(
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2)],
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                    leading: Container(
                      padding: EdgeInsets.only(right: 16),
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(width: 1),
                        ),
                      ),
                      child: SvgPicture.network(
                        model.listSpecialty[index].image,
                        width: 60,
                        height: 60,
                      ),
                    ),
                    title: Text(
                      model.listSpecialty[index].title,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    trailing: Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.black,
                      size: 30,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
