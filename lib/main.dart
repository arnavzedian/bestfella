import 'package:flutter/material.dart';

import 'widgets/AuthShield.dart';
import "./CentralState.dart";
import 'package:provider/provider.dart';
import './widgets/Home.dart';
import './widgets/AuthShield.dart';

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
          },
        ));
  }
}
