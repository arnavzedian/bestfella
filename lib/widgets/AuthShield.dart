import 'package:flutter/material.dart';
import '../CentralState.dart';
import 'package:provider/provider.dart';
import '../views/Intro.dart';

class AuthShield extends StatelessWidget {
  final Widget child;
  const AuthShield({Key? key, required this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print("rebuilding...");
    String? cookie = context.watch<CentralState>().cookie;

    if (cookie == null) return Intro();

    return this.child;
  }
}

/*

class GreenFrog extends StatelessWidget {
  const GreenFrog({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(color: const Color(0xFF2DBD3A));
  }
}

*/
