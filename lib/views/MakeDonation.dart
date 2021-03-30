import "package:flutter/material.dart";
import '../CentralState.dart';
import 'package:provider/provider.dart';
import "../widgets/TakeTextInput.dart";
// class TodoItem {
//   String item;
//   TodoItem(String item) {
//     this.item = item;
//   }
// }

class DonationButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.grey[900],
        child: Text(
          'Post',
          style: TextStyle(
              color: Colors.white, fontSize: 40.0, fontWeight: FontWeight.bold),
        ));
  }
}

class MainBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(30),
        child: SingleChildScrollView(
            child: Column(children: [
          TakeTextInput("title"),
          TakeTextInput("imageURL"),
          TakeTextInput("tag"),
          TakeTextInput("city"),
          TakeTextInput("gps"),
          DonationButton(),
        ])));
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
        body: MainBody());
  }
}
