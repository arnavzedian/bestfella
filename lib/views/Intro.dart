import "package:flutter/material.dart";
import '../CentralState.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

final String assetName = 'assets/logo.svg';
final Widget logo = SvgPicture.asset(assetName, semanticsLabel: 'Logo Button');

// class TodoItem {
//   String item;
//   TodoItem(String item) {
//     this.item = item;
//   }
// }

const Widget DonationHeader = Text(
  'Make someone happy',
  style: TextStyle(
      color: Colors.black87, fontSize: 40.0, fontWeight: FontWeight.bold),
);

const Widget DonationHeader2 = Text(
  'Make a donation',
  style: TextStyle(
      color: Colors.black87, fontSize: 20.0, fontWeight: FontWeight.bold),
);

class MainBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(30),
        child: SingleChildScrollView(
            child: Column(children: [logo, DonationHeader, DonationHeader2])));
  }
}

class Intro extends StatelessWidget {
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
        body: MainBody());
  }
}
