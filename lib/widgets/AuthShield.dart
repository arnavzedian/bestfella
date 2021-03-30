import 'package:flutter/material.dart';
import '../CentralState.dart';
import 'package:provider/provider.dart';
import 'Intro.dart';
import 'Loading.dart';

class AuthShield extends StatelessWidget {
  final Widget child;
  const AuthShield({Key? key, required this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print("rebuilding...");
    String? cookie = context.watch<CentralState>().cookie;
    String? error = context.watch<CentralState>().error;
    bool loading = context.watch<CentralState>().loading;

    if (error != null) return Text(error);
    if (loading == true) return Loading();
    if (cookie == null) return Intro();

    return Padding(padding: EdgeInsets.all(20), child: this.child);
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
