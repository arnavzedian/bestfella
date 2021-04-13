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
  'Donations',
  style: TextStyle(
      color: Colors.black87, fontSize: 40.0, fontWeight: FontWeight.bold),
);

const Widget note = Text(
  'All posts are deleted after 1 month to keep operation cost low',
  style: TextStyle(
      color: Colors.black87, fontSize: 12.0, fontWeight: FontWeight.normal),
);

class MainBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(children: [
      Profile(),
      // DonationHeader,
      // SizedBox(height: 12),
      // note,
      SizedBox(height: 25),
      RenderCards("profile")
    ]));
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
          padding: EdgeInsets.fromLTRB(25, 25, 25, 0),
          height: MediaQuery.of(context).size.height,
          child: MainBody(),
        )));
  }
}
