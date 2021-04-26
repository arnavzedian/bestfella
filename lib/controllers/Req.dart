import 'package:http/http.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import './Global.dart' as globals;

dynamic fetch(String path,
    [Map<String, dynamic> payload = const {},
    String method = "GET",
    absolute]) async {
  String? baseUrl = globals.env["server"];
  print(payload);
  print("requesting... $method $path");
  String? cookie = await readCookie();
  Map<String, dynamic>? query;

  if (method == "GET") query = payload;

  Uri url = Uri.https(baseUrl == null ? "" : baseUrl, "/api/v1$path", query);

  if (absolute == true) {
    url = Uri.parse(path);
  }

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

  print(data);

  if (absolute == true) {
    return data;
  }

  if (data["error"] != null) {
    String error = data["error"];
    throw ("error $error");
  }

  // print(data["data"]);
  return data["data"];
}

Future<String?> readCookie() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('cookie');
}
