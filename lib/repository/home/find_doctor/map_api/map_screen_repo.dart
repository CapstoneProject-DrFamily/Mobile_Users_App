import 'package:drFamily_app/model/home/find_doctor/map/place_predictions.dart';
import 'package:drFamily_app/model/home/find_doctor/map/user_current_address.dart';
import 'package:drFamily_app/repository/home/find_doctor/map_api/map_screen_assistant_repo.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

abstract class IMapScreenRepo {
  Future<UserCurrentAddress> searchCoordinateAddress(LatLng position);
  Future<List<PlacePredictions>> searchAddress(String searchValue);
}

class MapScreenRepo implements IMapScreenRepo {
  final IMapScreenAssistantRepo _map = MapScreenAssistantRepo();
  @override
  Future<UserCurrentAddress> searchCoordinateAddress(LatLng position) async {
    String placeAddress = "";
    UserCurrentAddress userPickUpAddress = new UserCurrentAddress();
    String url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=AIzaSyDFd7ZNm2BL2JREvk32NZJ0wHzUn2fjw4A';

    var response = await _map.getRequest(url);
    if (response != 'failed') {
      placeAddress = response["results"][0]["formatted_address"];

      userPickUpAddress.longtitude = position.longitude;
      userPickUpAddress.latitude = position.latitude;
      userPickUpAddress.placeName = placeAddress;
    }

    return userPickUpAddress;
  }

  @override
  Future<List<PlacePredictions>> searchAddress(String searchValue) async {
    String autoCompleteUrl =
        "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=${searchValue}&key=AIzaSyDFd7ZNm2BL2JREvk32NZJ0wHzUn2fjw4A&sessiontoken=1234567890&components=country:vn";
    var response = await _map.getRequest(autoCompleteUrl);
    List<PlacePredictions> listPrediction;

    if (response == "failed") return null;
    if (response["status"] == "OK") {
      var predictions = response["predictions"];
      listPrediction = (predictions as List)
          .map((e) => PlacePredictions.fromJson(e))
          .toList();
      return listPrediction;
    }
    return listPrediction;
  }
}
