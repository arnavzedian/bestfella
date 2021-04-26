import "package:flutter/material.dart";
import "../CentralState.dart";
import 'package:provider/provider.dart';
import "../widgets/BottomBar.dart";
import "../widgets/HomeHeader.dart";
import "../widgets/RenderCards.dart";
import "../widgets/CustomPadding.dart";
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
        padding: EdgeInsets.fromLTRB(10, 50, 10, 0),
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
      MainBody(),
      Positioned(left: 0, top: 0, child: HomeHeader()),
      Positioned(bottom: 15, right: 15, child: BottomBar()),
    ])));
  }
}
