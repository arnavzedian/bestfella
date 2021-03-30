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

class DonationInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Container(height: 200, width: 200, color: Colors.grey[200])),
      Column(
        children: [Text("product name"), Text("product details")],
      ),
    ]);
  }
}

class RequestPhoneNumber extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
            padding: EdgeInsets.all(10),
            color: Colors.grey[200],
            child: Text("request phone number")));
  }
}

class MainBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(30),
        child: SingleChildScrollView(
            child: Column(children: [
          DonationInfo(),
          Text("render gps"),
          RequestPhoneNumber()
        ])));
  }
}

class DonationDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black87),
            shadowColor: Colors.grey[50],
            title: Text(
              'Details',
              style: TextStyle(color: Colors.black87),
            ),
            backgroundColor: Colors.grey[200]),
        body: SafeArea(
            child: Container(
                padding: EdgeInsets.all(25),
                height: MediaQuery.of(context).size.height,
                child: Stack(children: [
                  MainBody(),
                  Positioned(bottom: 30, right: 30, child: BottomBar()),
                ]))));
  }
}
