import "package:flutter/material.dart";
import '../CentralState.dart';
import 'package:provider/provider.dart';
import '../widgets/TakeTextInput.dart';
import "../widgets/SaveButton.dart";
// class TodoItem {
//   String item;
//   TodoItem(String item) {
//     this.item = item;
//   }
// }

class MainBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Function saveLocalStorage = context.read<CentralState>().saveLocalStorage;
    Map data = context.watch<CentralState>().data;
    return SingleChildScrollView(
        child: Column(children: [
      TakeTextInput("GPS location"),
      SaveButton(() {
        if (data["GPS location"] != null)
          saveLocalStorage("GPS", data["GPS location"]);
      }),
    ]));
  }
}

class SaveLocation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black87),
            shadowColor: Colors.grey[50],
            title: Text(
              'Save City Name',
              style: TextStyle(color: Colors.black87),
            ),
            backgroundColor: Colors.grey[200]),
        body: SafeArea(
            child: Container(
                padding: EdgeInsets.fromLTRB(25, 25, 25, 0),
                child: MainBody())));
  }
}
