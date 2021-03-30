import "package:flutter/material.dart";
import '../CentralState.dart';
import 'package:provider/provider.dart';
import '../widgets/BottomBar.dart';
import '../widgets/Profile.dart';
import '../widgets/RenderCards.dart';

// class TodoItem {
//   String item;
//   TodoItem(String item) {
//     this.item = item;
//   }
// }

const Widget DonationHeader = Text(
  'Profile',
  style: TextStyle(
      color: Colors.black87, fontSize: 40.0, fontWeight: FontWeight.bold),
);

class MainBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(30),
        child: SingleChildScrollView(
            child: Column(children: [
          Profile(),
          DonationHeader,
          RenderCards("profile")
        ])));
  }
}

class User extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black87),
            shadowColor: Colors.grey[50],
            title: Text(
              'Profile',
              style: TextStyle(color: Colors.black87),
            ),
            backgroundColor: Colors.grey[200]),
        body: SafeArea(
            child: Container(
                height: MediaQuery.of(context).size.height,
                child: Stack(children: [
                  MainBody(),
                  Positioned(bottom: 30, right: 30, child: BottomBar()),
                ]))));
  }
}
