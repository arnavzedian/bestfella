import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "./controllers/Req.dart";
import '../controllers/Global.dart' as globals;
import 'package:flutter/material.dart';

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
    this.readLocalStorage("gps");
    this.readLocalStorage("city");
  }

  void clearData(String field) {
    config[field] = null;
    notifyListeners();
  }

  void load(String taskName, String path,
      {Map<String, dynamic> body = const {},
      String method = "GET",
      Function? callback}) async {
    config["loading-$taskName"] = true;
    notifyListeners();
    try {
      var data = await fetch(path, body, method);
      config["loading-$taskName"] = false;
      config[taskName] = data;
      print("taskName");
      print(config);
      notifyListeners();
      if (callback != null) {
        callback();
      }
    } catch (error) {
      if (globals.showDialog != null) {
        globals.showDialog?.call("error", error.toString());
      }
    }
  }

  void update(String field, value) {
    config[field] = value;
    notifyListeners();
  }
  //run readTodoList();

  void removeLocalStorage(String field) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove(field);
    config[field] = null;
    notifyListeners();
    print("removed $field");
  }

  void readLocalStorage(String field) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    config[field] = prefs.getString(field);
    notifyListeners();
  }

  void saveLocalStorage(String field, value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(field, value);
    config[field] = value;
    print("saving $field");
    notifyListeners();
  }

  /// Makes `Counter` readable inside the devtools by listing all of its properties
}
