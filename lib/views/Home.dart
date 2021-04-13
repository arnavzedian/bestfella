import "package:flutter/material.dart";
import "../CentralState.dart";
import 'package:provider/provider.dart';
import "../widgets/BottomBar.dart";
import "../widgets/HomeHeader.dart";
import "../widgets/RenderCards.dart";

// class TodoItem {
//   String item;
//   TodoItem(String item) {
//     this.item = item;
//   }
// }

class MainBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
        child: RenderCards(
            "feeds",
            SizedBox(
              height: 0,
            )));
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Stack(children: [
      Container(
          padding: EdgeInsets.fromLTRB(25, 25, 25, 0),
          height: MediaQuery.of(context).size.height,
          child: MainBody()),
      Positioned(left: 0, top: 0, child: HomeHeader()),
      Positioned(bottom: 35, right: 25, child: BottomBar()),
    ])));
  }
}
