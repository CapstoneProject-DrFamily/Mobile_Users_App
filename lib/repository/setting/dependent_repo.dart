import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:drFamily_app/Helper/api_helper.dart';
import 'package:drFamily_app/model/dependent_model.dart';

abstract class IDependentRepo {
  Future<List<DependentModel>> getListDependent(int accountID);
}

class DependentRepo extends IDependentRepo {
  @override
  Future<List<DependentModel>> getListDependent(int accountID) async {
    String urlAPI =
        APIHelper.GET_DEPENDENT_API + accountID.toString() + "/Dependents";
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    var response = await http.get(urlAPI, headers: header);
    print("Status: " + response.statusCode.toString());

    List<DependentModel> listDependent;

    if (response.statusCode == 200) {
      listDependent = (json.decode(response.body) as List)
          .map((data) => DependentModel.fromJson(data))
          .toList();
      listDependent.removeAt(0);
      return listDependent;
    } else
      return null;
  }
}
