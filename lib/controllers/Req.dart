import 'package:http/http.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

String baseUrl = "10.0.2.2:8080";

Future<Map> fetch(String path,
    [Map<String, dynamic> payload = const {}, String method = "GET"]) async {
  String? cookie = await readCookie();
  Map<String, dynamic>? query;
  print("doing fetching...1");
  if (method == "GET") query = payload;

  Uri url = Uri.http(baseUrl, "/api/v1$path", query);
  print("doing fetching...2");
  Response response;
  Map<String, String> headers = {
    "Content-type": "application/json",
    "Authorization": cookie == null ? "" : "Bearer $cookie"
  };
  if (method == "GET") {
    print("doing fetching...");
    response = await get(url, headers: headers);
  } else {
    response = await post(url, headers: headers, body: payload);
  }

  Map data = jsonDecode(response.body);
  print(data);
  if (data["error"] != null) {
    String error = data["error"];
    throw ("error $error");
  }
  return data["data"];
}

Future<String?> readCookie() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('cookie');
}
