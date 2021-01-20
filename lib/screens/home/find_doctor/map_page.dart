import 'package:drFamily_app/screens/share/base_view.dart';
import 'package:drFamily_app/view_model/home_vm/find_doctor_vm/map_page_view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   title: Text(''),
      //   backgroundColor: Colors.white,
      // ),
      body: BaseView<MapPageViewModel>(
        builder: (context, child, model) {
          if (model.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else
            return Stack(
              children: [
                GoogleMap(
                  padding: EdgeInsets.only(bottom: model.bottomPadding),
                  initialCameraPosition: model.initPosition,
                  myLocationButtonEnabled: false,
                  myLocationEnabled: true,
                  zoomGesturesEnabled: true,
                  zoomControlsEnabled: false,
                  onMapCreated: model.onMapCreated,
                ),
                // Positioned(
                //   top: 0.0,
                //   left: 0.0,
                //   right: 0.0,
                //   child: AppBar(
                //     title: Text(''), // You can add title here
                //     leading: new IconButton(
                //       icon: new Icon(Icons.arrow_back_ios, color: Colors.grey),
                //       onPressed: () => Navigator.of(context).pop(),
                //     ),
                //     backgroundColor: Colors.blue
                //         .withOpacity(0), //You can make this transparent
                //     elevation: 0.0, //No shadow
                //   ),
                // ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                  child: TextFormField(
                    controller: model.addressController,
                    // onChanged: (value) => model.changePhoneNum(value),
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
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 10.0),
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
                ),
                Padding(
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
                ),
                Positioned(
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
                ),
                Positioned(
                  left: 0,
                  bottom: 0,
                  right: 0,
                  child: Container(
                    height: 75,
                    decoration: BoxDecoration(color: Colors.white),
                    child: Container(
                      margin: EdgeInsets.all(15),
                      child: RaisedButton(
                        onPressed: () {},
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(80.0)),
                        padding: EdgeInsets.all(0.0),
                        child: Ink(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xff374ABE), Color(0xff64B6FF)],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(30.0)),
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              "Continue",
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
        },
      ),
    );
  }
}
