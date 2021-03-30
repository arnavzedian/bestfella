import "package:flutter/material.dart";
import '../CentralState.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../controllers/Auth.dart';

final String assetName = 'assets/logo.svg';
final Widget logo = SvgPicture.asset(assetName, semanticsLabel: 'Logo ');

final String assetName2 = 'assets/google.svg';
final Widget google =
    SvgPicture.asset(assetName, semanticsLabel: 'Google logo');
// class TodoItem {
//   String item;
//   TodoItem(String item) {
//     this.item = item;
//   }
// }

const Widget DonationHeader = Text(
  'Make someone happy',
  style: TextStyle(
      color: Colors.black87, fontSize: 40.0, fontWeight: FontWeight.bold),
);

const Widget DonationHeader2 = Text(
  'Make a donation',
  style: TextStyle(
      color: Colors.black87, fontSize: 20.0, fontWeight: FontWeight.bold),
);

class LoginWithGoogle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Function saveLocalStorage = context.watch<CentralState>().saveLocalStorage;
    Function update = context.watch<CentralState>().update;

    void attemptSignIn() async {
      try {
        String? cookie = await Auth.signIn();
        if (cookie != null) saveLocalStorage("cookie", cookie);
      } catch (enError) {
        update("error", enError);
      }
    }

    return GestureDetector(
        onTap: attemptSignIn,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Container(
                margin: const EdgeInsets.all(15.0),
                padding: const EdgeInsets.all(3.0),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.blueAccent)),
                child: Row(children: [google, Text("Login with google")]))));
  }
}

class MainBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(children: [
      logo,
      DonationHeader,
      DonationHeader2,
      SizedBox(
        height: 300.0,
      ),
      LoginWithGoogle()
    ]));
  }
}

class Intro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black87),
            shadowColor: Colors.grey[50],
            title: Text(
              'Profile',
              style: TextStyle(color: Colors.black87),
            ),
            backgroundColor: Colors.grey[200]),
        body: SafeArea(
            child: Container(
                padding: EdgeInsets.fromLTRB(25, 25, 25, 0),
                child: MainBody())));
  }
}
