import 'dart:convert';

import 'package:http/http.dart' as http;

abstract class IMapScreenAssistantRepo {
  Future<dynamic> getRequest(String url);
}

class MapScreenAssistantRepo implements IMapScreenAssistantRepo {
  @override
  Future<dynamic> getRequest(String url) async {
    http.Response response = await http.get(url);

    try {
      if (response.statusCode == 200) {
        String jSonData = response.body;
        var decodeData = jsonDecode(jSonData);
        return decodeData;
      } else
        return "failed";
    } catch (exp) {
      return "failed";
    }
  }
}
