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
    return Padding(
        padding: EdgeInsets.all(30),
        child: SingleChildScrollView(
            child: Column(children: [HomeHeader(), RenderCards("feeds")])));
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
                height: MediaQuery.of(context).size.height,
                child: Stack(children: [
                  MainBody(),
                  Positioned(bottom: 30, right: 30, child: BottomBar()),
                ]))));
  }
}
