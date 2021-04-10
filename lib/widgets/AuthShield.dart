import 'package:flutter/material.dart';
import '../CentralState.dart';
import 'package:provider/provider.dart';
import '../views/Intro.dart';
import '../widgets/Loading.dart';
import '../views/SaveCityName.dart';
import '../controllers/Global.dart' as globals;

class AuthShield extends StatelessWidget {
  final Widget child;
  const AuthShield({Key? key, required this.child}) : super(key: key);
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

    print("rebuilding...");
    String? cookie = context.watch<CentralState>().cookie;
    Map data = context.watch<CentralState>().data;

    if (data["loading-signin"] != null) {
      if (data["loading-signin"] == true) return Loading();
    }

    if (cookie == null) return Intro();

    if (data["preference-city"] == null) {
      return SaveCityName();
    }

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
