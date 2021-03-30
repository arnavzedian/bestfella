import "package:flutter/material.dart";
import '../CentralState.dart';
import 'package:provider/provider.dart';
import "../widgets/TakeTextInput.dart";
import "../widgets/SaveButton.dart";
// class TodoItem {
//   String item;
//   TodoItem(String item) {
//     this.item = item;
//   }SaveButton
// }

class MainBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(children: [
      TakeTextInput("title"),
      TakeTextInput("imageURL"),
      TakeTextInput("tag"),
      TakeTextInput("city"),
      TakeTextInput("gps"),
      SaveButton(),
    ]));
  }
}

class MakeDonation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black87),
            shadowColor: Colors.grey[50],
            title: Text(
              'Make a donation',
              style: TextStyle(color: Colors.black87),
            ),
            backgroundColor: Colors.grey[200]),
        body: SafeArea(
            child: Container(
                padding: EdgeInsets.fromLTRB(25, 25, 25, 0),
                child: MainBody())));
  }
}
