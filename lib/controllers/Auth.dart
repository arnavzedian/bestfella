import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';
import "./Req.dart";

GoogleSignIn _googleSignIn = GoogleSignIn(
  // Optional clientId
  // clientId:
  //     '55061573896-3fcp4delkl1pc4aguk8gm6l2baqq69jd.apps.googleusercontent.com',
  scopes: <String>['email'],
);

class Auth {
  static Future<void> signOut() async {
    _googleSignIn.disconnect();
  }

  static Future<String?> signIn() async {
    try {
      final result = await _googleSignIn.signIn();
      final ggAuth = await result?.authentication;

      String? accessToken = ggAuth?.accessToken;

      print(accessToken);

      Map cookieData =
          await fetch("/auth/cookie", {"accessToken": accessToken});
      return cookieData["token"];
    } catch (error) {
      throw (error);
    }
  }
}
