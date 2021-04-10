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
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import './widgets/AuthShield.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
// Unhandled Exception: No MaterialLocalizations foun
import '../controllers/Global.dart' as globals;

Future main() async {
  // await DotEnv.load();
  print(
      "-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------");
  await DotEnv.load(fileName: ".env");

  globals.env = DotEnv.env;

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
