import 'package:drFamily_app/view_model/landing_page_vm/map_tracking_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class MapTrackingScreen extends StatelessWidget {
  final MapTrackingScreenViewModel model;

  MapTrackingScreen({@required this.model});

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MapTrackingScreenViewModel>(
      model: model,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ScopedModelDescendant<MapTrackingScreenViewModel>(
          builder: (context, child, model) {
            if (model.isLoading == true) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              );
            } else
              return Stack(
                children: [
                  SlidingUpPanel(
                    maxHeight: MediaQuery.of(context).size.height * .80,
                    minHeight: model.panelHeightClosed,
                    parallaxEnabled: true,
                    parallaxOffset: .5,
                    body: _buildGoogleMap(model),
                    panelBuilder: (sc) => _panel(sc, context, model),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(18.0),
                        topRight: Radius.circular(18.0)),
                    onPanelSlide: (double pos) {
                      model.slidePanel(pos, context);
                    },
                  ),
                  // the fab
                  _buildMyLocation(model, context),
                  _buildArrivedButtom(context, model),
                ],
              );
          },
        ),
      ),
    );
  }

  Positioned _buildMyLocation(
      MapTrackingScreenViewModel model, BuildContext context) {
    return Positioned(
      right: 20.0,
      bottom: model.fabHeight,
      child: FloatingActionButton(
        child: Icon(
          Icons.gps_fixed,
          color: Theme.of(context).primaryColor,
        ),
        onPressed: () {
          model.getCurrentPosition();
        },
        backgroundColor: Colors.white,
      ),
    );
  }

  Positioned _buildArrivedButtom(
      BuildContext context, MapTrackingScreenViewModel model) {
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
              model.cancelTransaction(context);
            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(80.0)),
            padding: EdgeInsets.all(0.0),
            child: Ink(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.red, Colors.red[300]],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(30.0)),
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  "CANCEL",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  GoogleMap _buildGoogleMap(MapTrackingScreenViewModel model) {
    return GoogleMap(
      padding: EdgeInsets.only(bottom: model.bottomPadding),
      initialCameraPosition: model.initPosition,
      myLocationButtonEnabled: false,
      myLocationEnabled: true,
      zoomGesturesEnabled: true,
      zoomControlsEnabled: false,
      onMapCreated: model.onMapCreated,
      markers: model.markers,
      // onTap: model.handleTap,
    );
  }

  Widget _panel(ScrollController sc, BuildContext context,
      MapTrackingScreenViewModel model) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView(
        controller: sc,
        children: <Widget>[
          SizedBox(
            height: 12.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 30,
                height: 5,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.all(Radius.circular(12.0))),
              ),
            ],
          ),
          SizedBox(
            height: 18.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Booking Infomation",
                style: GoogleFonts.varelaRound(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.blueAccent,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 24),
                  child: Text(
                    model.transactionMapModel.doctorName,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: GoogleFonts.varelaRound(
                      fontWeight: FontWeight.normal,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 30),
                child: Icon(Icons.call),
              ),
            ],
          ),
          SizedBox(
            height: 16.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Text(
                  model.durationString,
                  style: GoogleFonts.varelaRound(
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: EdgeInsets.only(left: 18),
            child: Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: Colors.blue,
                  size: 30,
                ),
                Expanded(
                  child: Container(
                    child: Text(
                      model.transactionMapModel.placeName,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: GoogleFonts.varelaRound(
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 36.0,
          ),
          Container(
            padding: const EdgeInsets.only(left: 24.0, right: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Doctor Image",
                  style: GoogleFonts.varelaRound(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 12.0,
                ),
                Container(
                  child: _imageField(context, model),
                )
              ],
            ),
          ),
          SizedBox(
            height: 36.0,
          ),
          Container(
            padding: const EdgeInsets.only(left: 24.0, right: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Doctor Specialty",
                  style: GoogleFonts.varelaRound(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 12.0,
                ),
                Container(
                  child: Text(
                    model.transactionMapModel.doctorSpecialty,
                    softWrap: true,
                    style: GoogleFonts.varelaRound(
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 36.0,
          ),
          Container(
            padding: const EdgeInsets.only(left: 24.0, right: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Doctor Degree",
                  style: GoogleFonts.varelaRound(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 12.0,
                ),
                Container(
                  child: Text(
                    model.transactionMapModel.doctorDegree,
                    softWrap: true,
                    style: GoogleFonts.varelaRound(
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 36.0,
          ),
          Container(
            padding: const EdgeInsets.only(left: 24.0, right: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Symptoms",
                  style: GoogleFonts.varelaRound(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 12.0,
                ),
                model.symptomsDisplay.length != 0
                    ? ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: model.symptomsDisplay.length,
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Text(
                                  model.symptomsDisplay[index].symptomtype,
                                  style: GoogleFonts.varelaRound(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 25),
                                child: Text(
                                  model.symptomsDisplay[index].symptomName,
                                  softWrap: true,
                                  style: GoogleFonts.varelaRound(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 12.0,
                              ),
                            ],
                          );
                        },
                      )
                    : Text(
                        "Nothing",
                        style: GoogleFonts.varelaRound(
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      )
              ],
            ),
          ),
          SizedBox(
            height: 36,
          ),
          Container(
            padding: const EdgeInsets.only(left: 24.0, right: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Service",
                  style: GoogleFonts.varelaRound(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 12.0,
                ),
                Container(
                  child: Text(
                    '${model.transactionMapModel.serviceName} - ${model.transactionMapModel.servicePrice}',
                    softWrap: true,
                    style: GoogleFonts.varelaRound(
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 36,
          ),
          Container(
            padding: const EdgeInsets.only(left: 24.0, right: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Note",
                  style: GoogleFonts.varelaRound(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 12.0,
                ),
                Container(
                  child: Text(
                    model.transactionMapModel.transactionNote,
                    softWrap: true,
                    style: GoogleFonts.varelaRound(
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 120,
          ),
        ],
      ),
    );
  }

  Widget _button(String label, IconData icon, Color color) {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(16.0),
          child: Icon(
            icon,
            color: Colors.white,
          ),
          decoration:
              BoxDecoration(color: color, shape: BoxShape.circle, boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.15),
              blurRadius: 8.0,
            )
          ]),
        ),
        SizedBox(
          height: 12.0,
        ),
        Text(label),
      ],
    );
  }

  Widget _imageField(BuildContext context, MapTrackingScreenViewModel model) {
    return Container(
      child: Align(
        alignment: Alignment.center,
        child: CircleAvatar(
          radius: 50.0,
          backgroundImage: NetworkImage(model.transactionMapModel.doctorImage),
        ),
      ),
    );
  }
}
