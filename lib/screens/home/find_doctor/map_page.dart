import 'package:drFamily_app/screens/landing_page/lading_page.dart';
import 'package:drFamily_app/screens/share/base_view.dart';
import 'package:drFamily_app/view_model/home_vm/find_doctor_vm/map_page_view_model.dart';
import 'package:drFamily_app/view_model/home_vm/time_line/base_time_line_view_model.dart';
import 'package:drFamily_app/view_model/home_vm/time_line_appoinment/base_time_line_appoiment_view_model.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatelessWidget {
  final BaseTimeLineViewModel baseTimeLineViewModel;
  final BaseTimeLineAppoinmentViewModel baseTimeLineAppoinmentViewModel;
  MapScreen({this.baseTimeLineViewModel, this.baseTimeLineAppoinmentViewModel});
  @override
  Widget build(BuildContext context) {
    return BaseView<MapPageViewModel>(
      builder: (context, child, model) {
        if (model.isLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Stack(
            children: [
              _buildGoogleMap(model),
              _buildSearchAddressField(model),
              _buildButtomMyLocation(model),
              _buildImportantMessage(),
              _buildContinueButtom(context, model),
              model.currentSearch.length > 1
                  ? Container(
                      margin: EdgeInsets.only(top: 60, left: 20, right: 20),
                      child: MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: ListView.separated(
                          separatorBuilder: (context, index) => Divider(
                            height: 0.01,
                          ),
                          primary: false,
                          shrinkWrap: true,
                          itemCount: model.listAddress.length,
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: ListTile(
                                leading: Transform.translate(
                                  offset: Offset(-7, 0),
                                  child: Icon(
                                    Icons.location_on,
                                    color: Colors.greenAccent[400],
                                    size: 30,
                                  ),
                                ),
                                title: Transform.translate(
                                  offset: Offset(-7, 0),
                                  child:
                                      Text(model.listAddress[index].main_text),
                                ),
                                subtitle: Transform.translate(
                                  offset: Offset(-7, 0),
                                  child: Text(
                                      model.listAddress[index].secondary_text),
                                ),
                                onTap: () {
                                  model.chooseLocation(
                                      model.listAddress[index].place_id);
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  : Container(
                      child: Text(""),
                    ),
            ],
          );
        }
      },
    );
  }

  AppBar _buildAppbar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.0, //No shadow
      leading: new IconButton(
        icon: new Icon(Icons.arrow_back_ios, color: Colors.black),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            alignment: Alignment.center,
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Color(0xff567feb),
            ),
            child: IconButton(
              icon: Icon(EvaIcons.home, color: Colors.white),
              onPressed: () {
                _confirmDialog(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  Future _confirmDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (alertContext) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          child: Container(
            height: 380,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              children: [
                SizedBox(
                  height: 25,
                ),
                Icon(
                  Icons.info,
                  color: Color(0xff4ee1c7),
                  size: 90,
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  "Please Note",
                  style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'avenir',
                    color: Color(0xff0d47a1),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  'You have not finished booking your',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'avenir',
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'appointment. Are you sure that you would',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'avenir',
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'like to go back to the home page?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'avenir',
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 45,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      customBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      onTap: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => LandingScreen()),
                            (Route<dynamic> route) => false);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: MediaQuery.of(alertContext).size.width * 0.3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.blueAccent),
                        ),
                        child: Text(
                          "Yes",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'avenir',
                            color: Colors.blueAccent,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      customBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: MediaQuery.of(alertContext).size.width * 0.3,
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.blueAccent),
                        ),
                        child: Text(
                          "No",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'avenir',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Positioned _buildContinueButtom(
      BuildContext context, MapPageViewModel model) {
    return Positioned(
      left: 0,
      bottom: 0,
      right: 0,
      child: Container(
        height: 75,
        decoration: BoxDecoration(color: Colors.white),
        child: Container(
          margin: EdgeInsets.all(15),
          child: RaisedButton(
            onPressed: () {
              if (!model.isEnable) {
              } else {
                model.doneMap(context, baseTimeLineViewModel,
                    baseTimeLineAppoinmentViewModel);
              }
            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(80.0)),
            padding: EdgeInsets.all(0.0),
            child: Ink(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      !model.isEnable
                          ? Color(0xff374ABE).withOpacity(0.4)
                          : Color(0xff374ABE),
                      !model.isEnable
                          ? Color(0xff64B6FF).withOpacity(0.4)
                          : Color(0xff64B6FF)
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(30.0)),
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  "Save",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Positioned _buildImportantMessage() {
    return Positioned(
      left: 0,
      bottom: 75,
      right: 0,
      child: Opacity(
        opacity: 0.9,
        child: Container(
          height: 30,
          decoration: BoxDecoration(color: Colors.white),
          child: Center(
            child: Text(
              'In case of emergency, contact the nearest hospital',
              style: GoogleFonts.varelaRound(
                fontWeight: FontWeight.normal,
                color: Colors.blue,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Padding _buildButtomMyLocation(MapPageViewModel model) {
    return Padding(
      padding: EdgeInsets.only(bottom: 115, right: 10),
      child: Align(
        alignment: Alignment.bottomRight,
        child: FloatingActionButton(
          onPressed: () {
            model.locatePosition();
          },
          backgroundColor: Colors.white,
          child: Icon(
            Icons.my_location,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Padding _buildSearchAddressField(MapPageViewModel model) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: TextFormField(
        controller: model.addressController,
        onChanged: (value) => model.searchPlace(value),
        style: GoogleFonts.varelaRound(
          fontWeight: FontWeight.normal,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          hintText: "Enter your location",
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Icon(
            Icons.location_on,
            color: Colors.blue,
            size: 30,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
          suffixIcon: model.addressController.text.isEmpty
              ? null
              : InkWell(
                  onTap: () => model.addressController.clear(),
                  child: Icon(Icons.clear),
                ),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }

  GoogleMap _buildGoogleMap(MapPageViewModel model) {
    return GoogleMap(
      padding: EdgeInsets.only(bottom: model.bottomPadding),
      initialCameraPosition: model.initPosition,
      myLocationButtonEnabled: false,
      myLocationEnabled: true,
      zoomGesturesEnabled: true,
      zoomControlsEnabled: false,
      onMapCreated: model.onMapCreated,
      markers: model.markers,
      onTap: model.handleTap,
    );
  }
}
