import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class NetworkHanler {
  String burl = "https://murmuring-thicket-37937.herokuapp.com";

  FlutterSecureStorage storage = const FlutterSecureStorage();

  Future<dynamic> get(var url) async {
    url = formatter(url);
    url = Uri.parse(url);
    var token = await storage.read(key: "token");

    var response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return json.decode(response.body);
    }
  }

  Future<http.Response> post(var url, Map<String, String> body) async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    var token = await storage.read(key: "token");
    url = formatter(url);
    url = Uri.parse(url);
    var response = await http.post(
      url,
      headers: {
        'Content-type': "application/json",
        "Authorization": "Bearer $token"
      },
      body: json.encode(body),
    );
    return response;
  }

  String formatter(String url) {
    return burl + url;
  }
}
