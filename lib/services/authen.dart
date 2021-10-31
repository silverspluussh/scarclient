import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkHanler {
  String burl = "gdfd";

  Future<dynamic> get(var _url) async {
    _url = formater(_url);
    var response = await http.get(_url);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return json.decode(response.body);
    }
  }

  Future<dynamic> post(var _url, Map<String, String> body) async {
    _url = formater(_url);
    var response = await http.post(
      _url,
      headers: {'Content-type': "application/json"},
      body: json.encode(body),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return response;
    }
  }

  String formater(String url) {
    return burl + url;
  }
}
