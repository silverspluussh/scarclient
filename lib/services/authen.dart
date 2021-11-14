import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class NetworkHanler {
  String burl = "https://mighty-headland-63561.herokuapp.com";

  FlutterSecureStorage storage = const FlutterSecureStorage();

  Future get(var url) async {
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

  Future<http.StreamedResponse> imagepatch(String url, String path) async {
    url = formatter(url);
    var token = await storage.read(key: "token");
    var request = http.MultipartRequest("PATCH", Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath("img", path));
    request.headers.addAll({
      "Content-type": "multipart/form-data",
      "Authorization": "Bearer $token",
    });
    var resp = request.send();
    return resp;
  }

  String formatter(String url) {
    return burl + url;
  }

  NetworkImage getimage(String username) {
    String url = formatter('/uploads//$username');
    return NetworkImage(url);
  }
}
