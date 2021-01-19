import 'package:drFamily_app/screens/share/base_view.dart';
import 'package:drFamily_app/view_model/home_vm/find_doctor_vm/map_page_view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Choice Location'),
      ),
      body: BaseView<MapPageViewModel>(
        builder: (context, child, model) {
          return Stack(
            children: [
              GoogleMap(
                initialCameraPosition: model.initPosition,
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
                zoomGesturesEnabled: true,
                zoomControlsEnabled: true,
                onMapCreated: model.onMapCreated,
              ),
            ],
          );
        },
      ),
    );
  }
}
