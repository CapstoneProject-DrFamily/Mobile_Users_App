import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: const Text('Your location'),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(10.7915178, 106.7271422),
                zoom: 11.0,
              ),
            ),
            Positioned(
              left: 0,
              top: 0,
              right: 0,
              child: Column(
                children: <Widget>[
                  AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    title: Text(
                      "Choose your location",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    // leading: FlatButton(
                    //   onPressed: (){},
                    //   child: null,
                    // ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
