import 'package:flutter/material.dart';

import 'widgets/AuthShield.dart';
import "./CentralState.dart";
import 'package:provider/provider.dart';
// import './widgets/Home.dart';
import './views/Home.dart';
import './views/DonationDetails.dart';
import './views/MakeDonation.dart';
import './views/SaveCityName.dart';
import './views/SaveLocation.dart';
import './views/SavePhoneNumber.dart';
import './views/User.dart';
import "./classes/ScreenArguments.dart";
import './widgets/AuthShield.dart';

// Unhandled Exception: No MaterialLocalizations foun
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CentralState()),
        ],
        child: MaterialApp(
          routes: {
            '/': (context) => AuthShield(child: Home()),
            '/make-donation': (context) => AuthShield(child: MakeDonation()),
            "/donation-details": (context) =>
                AuthShield(child: DonationDetails()),
            '/save-city-name': (context) => AuthShield(child: SaveCityName()),
            '/save-location': (context) => AuthShield(child: SaveLocation()),
            '/save-phone-number': (context) =>
                AuthShield(child: SavePhoneNumber()),
            '/profile': (context) => AuthShield(child: User()),
          },
        ));
  }
}
