import 'package:drFamily_app/screens/share/base_view.dart';
import 'package:drFamily_app/view_model/map_choose_profile_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapChooseProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<MapChooseProfileViewModel>(
      builder: (context, child, model) {
        if (model.isLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Scaffold(
            appBar: _buildAppBar(context),
            body: Stack(
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
                                    child: Text(
                                        model.listAddress[index].main_text),
                                  ),
                                  subtitle: Transform.translate(
                                    offset: Offset(-7, 0),
                                    child: Text(model
                                        .listAddress[index].secondary_text),
                                  ),
                                  onTap: () {
                                    FocusScope.of(context)
                                        .requestFocus(new FocusNode());
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
            ),
          );
        }
      },
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return new AppBar(
      backgroundColor: Colors.transparent,
      centerTitle: true,
      elevation: 0,
      leading: new IconButton(
        icon: new Icon(Icons.arrow_back_ios, color: Color(0xff374ABE)),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: new Text(
        "Choose Location",
        style: TextStyle(color: Color(0xff374ABE)),
      ),
    );
  }

  Positioned _buildContinueButtom(
      BuildContext context, MapChooseProfileViewModel model) {
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
                model.doneMap(context);
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

  Padding _buildButtomMyLocation(MapChooseProfileViewModel model) {
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

  Padding _buildSearchAddressField(MapChooseProfileViewModel model) {
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

  GoogleMap _buildGoogleMap(MapChooseProfileViewModel model) {
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
