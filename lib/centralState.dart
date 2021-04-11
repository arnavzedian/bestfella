import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "./controllers/Req.dart";
import '../controllers/Global.dart' as globals;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart' as http_parser;
import 'dart:io';
import 'dart:convert';

class CentralState with ChangeNotifier {
  Map<String, dynamic> config = {"loading": false};

//what we need to do here
  Map get data => config;
  String? get error => config["error"];
  String? get cookie => config["cookie"];
  bool get loading => config["loading"];
//we need to make an http request
//save the the cookie

  CentralState() {
    this.readLocalStorage("cookie");
    this.readLocalStorage("preference-latitude");
    this.readLocalStorage("preference-longitude");
    this.readLocalStorage("preference-city");
    this.readLocalStorage("preference-state");
    this.readLocalStorage("preference-country");
  }

  void clearData(String field) {
    config[field] = null;
    //render();
  }

  void load(String taskName, String path,
      {Map<String, dynamic> body = const {},
      String method = "GET",
      bool absolute = false,
      Function? callback,
      String source = "initState"}) async {
    config["loading-$taskName"] = true;
    if (source != "initState") render();
    try {
      var data = await fetch(path, body, method, absolute);
      config["loading-$taskName"] = false;
      config[taskName] = data;

      render();
      if (callback != null) {
        callback(data);
      }
    } catch (error) {
      if (globals.showDialog != null) {
        globals.showDialog?.call("error", error.toString());
      }
    }
  }

  void selectImage() async {
    final picker = ImagePicker();

    this.config["uploadingImage"] = true;
    render();

    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      this.config["selectedImageLink"] = pickedFile.path;
      render();
      uploadFile(pickedFile.path);
    } else {
      this.config["uploadingImage"] = false;
      render();
    }
  }

  void uploadFile(String path) async {
    String serverURL = globals.server;
    var postUri = Uri.http(serverURL, "/api/v1/uploads");

    var request = new http.MultipartRequest("POST", postUri);

    request.files.add(await http.MultipartFile.fromPath('file', path));

    http.Response response =
        await http.Response.fromStream(await request.send());

    Map data = jsonDecode(response.body);

    if (data["error"] != null) {
      globals.showDialog?.call("error", data["error"]);
    } else {
      this.config["uploadingImage"] = false;
      this.config["uploadedImage"] = data["data"]["url"];

      render();
    }
  }

  void update(String field, value) {
    config[field] = value;

    render();
  }

  void change(String field, value) {
    config[field] = value;
  }

  void render() {
    print("requesting ui update");
    notifyListeners();
  }
  //run readTodoList();

  void removeLocalStorage(String field) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove(field);
    config[field] = null;
    render();
  }

  void readLocalStorage(String field) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    config[field] = prefs.getString(field);
    render();
    if (field == "cookie" && config[field] != null) {
      this.load("userProfile", "/profile");
    }
  }

  void saveLocalStorage(String field, value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(field, value);
    config[field] = value;

    render();
  }

  /// Makes `Counter` readable inside the devtools by listing all of its properties
}
