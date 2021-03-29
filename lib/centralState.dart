import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CentralState with ChangeNotifier {
  String? _cookie;
  String? _error;
  bool _loading = true;
//what we need to do here
  String? get error => _error;
  String? get cookie => _cookie;
  bool get loading => _loading;
//we need to make an http request
//save the the cookie

  CentralState() {
    this.readCookie();
  }

  void warnUser(String value) {
    _error = value;
    notifyListeners();
  }
  //run readTodoList();

  void removeCookie() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove('cookie');
    _cookie = null;
    notifyListeners();
    print("removed cookie");
  }

  void saveCookie(val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('cookie', val);
    _cookie = val;
    print("saving cookie");
    notifyListeners();
  }

  void readCookie() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _cookie = prefs.getString('cookie');
    _loading = false;
    notifyListeners();
  }

  /// Makes `Counter` readable inside the devtools by listing all of its properties
}
