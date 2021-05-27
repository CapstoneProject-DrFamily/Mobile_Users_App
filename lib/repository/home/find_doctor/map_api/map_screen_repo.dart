import 'package:drFamily_app/global_variable.dart';
import 'package:drFamily_app/model/home/find_doctor/map/place_predictions.dart';
import 'package:drFamily_app/model/home/find_doctor/map/user_current_address.dart';
import 'package:drFamily_app/repository/home/find_doctor/map_api/map_screen_assistant_repo.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

abstract class IMapScreenRepo {
  Future<UserCurrentAddress> searchCoordinateAddress(LatLng position);
  Future<List<PlacePredictions>> searchAddress(String searchValue);
  Future<UserCurrentAddress> getPlaceAddressDetails(String placeId);
}

class MapScreenRepo implements IMapScreenRepo {
  final IMapScreenAssistantRepo _map = MapScreenAssistantRepo();
  @override
  Future<UserCurrentAddress> searchCoordinateAddress(LatLng position) async {
    String placeAddress = "";
    UserCurrentAddress userPickUpAddress = new UserCurrentAddress();
    String url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$GoogleKey';

    var response = await _map.getRequest(url);
    if (response != 'failed') {
      placeAddress = response["results"][0]["formatted_address"];

      userPickUpAddress.placeID = response["results"][0]["place_id"];
      userPickUpAddress.longtitude = position.longitude;
      userPickUpAddress.latitude = position.latitude;
      userPickUpAddress.placeName = placeAddress;
    }

    return userPickUpAddress;
  }

  @override
  Future<List<PlacePredictions>> searchAddress(String searchValue) async {
    String autoCompleteUrl =
        "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=${searchValue}&key=$GoogleKey&sessiontoken=1234567890&components=country:vn";
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

  @override
  Future<UserCurrentAddress> getPlaceAddressDetails(String placeId) async {
    String placeDetailsUrl =
        "https://maps.googleapis.com/maps/api/place/details/json?place_id=${placeId}&key=$GoogleKey";
    var response = await _map.getRequest(placeDetailsUrl);

    UserCurrentAddress userPickUpAddress = new UserCurrentAddress();

    if (response == "failed") {
      return userPickUpAddress;
    }

    if (response["status"] == "OK") {
      userPickUpAddress.placeName = response["result"]["formatted_address"];
      userPickUpAddress.placeID = placeId;
      userPickUpAddress.latitude =
          response["result"]["geometry"]["location"]["lat"];
      userPickUpAddress.longtitude =
          response["result"]["geometry"]["location"]["lng"];
      return userPickUpAddress;
    }

    return userPickUpAddress;
  }
}
