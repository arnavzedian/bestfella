import 'package:flutter/material.dart';

import 'widgets/AuthShield.dart';
import "./CentralState.dart";
import 'package:provider/provider.dart';
// import './widgets/Home.dart';
import './views/Home.dart';
import './views/Intro.dart';
import './views/MakeDonation.dart';
import './views/SaveCityName.dart';
import './views/SaveLocation.dart';
import './views/SavePhoneNumber.dart';
import './views/User.dart';

import './widgets/AuthShield.dart';
import './controllers/Global.dart' as globals;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void _showMyDialog(String text, String text2) async {
      showDialog<void>(
        context: context,
        barrierDismissible: true, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(text),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[Text(text2)],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Okay'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    globals.showDialog = _showMyDialog;

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CentralState()),
        ],
        child: MaterialApp(
          routes: {
            '/': (context) => AuthShield(child: Home()),
            '/intro': (context) => AuthShield(child: Intro()),
            '/make-donation': (context) => AuthShield(child: MakeDonation()),
            '/save-city-name': (context) => AuthShield(child: SaveCityName()),
            '/save-location': (context) => AuthShield(child: SaveLocation()),
            '/save-phone-number': (context) =>
                AuthShield(child: SavePhoneNumber()),
            '/user': (context) => AuthShield(child: User()),
          },
        ));
  }
}
