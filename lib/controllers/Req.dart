import 'package:http/http.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

String baseUrl = "10.0.2.2:8080";

dynamic fetch(String path,
    [Map<String, dynamic> payload = const {}, String method = "GET"]) async {
  String? cookie = await readCookie();
  Map<String, dynamic>? query;

  if (method == "GET") query = payload;

  Uri url = Uri.http(baseUrl, "/api/v1$path", query);

  Response response;
  Map<String, String> headers = {
    "Content-type": "application/json",
    "Authorization": cookie == null ? "" : "Bearer $cookie"
  };
  if (method == "GET") {
    response = await get(url, headers: headers);
  } else {
    response = await post(url, headers: headers, body: jsonEncode(payload));
  }

  Map data = jsonDecode(response.body);

  if (data["error"] != null) {
    String error = data["error"];
    throw ("error $error");
  }
  print("start-req.dart");
  print(path);
  print(data["data"]);
  print("end-req.dart");
  return data["data"];
}

Future<String?> readCookie() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('cookie');
}
