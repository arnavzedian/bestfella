import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';
import '../CentralState.dart';
import 'package:provider/provider.dart';
import '../classes/ScreenArguments.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TypeButton extends StatelessWidget {
  TypeButton(this.trigger, this.currentState, this.label);
  final Function trigger;
  final String currentState;
  final String label;

  @override
  Widget build(BuildContext context) {
    Widget active = Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.circular(8)),
        child: Center(
            child: Text("$label", style: TextStyle(color: Colors.white))));

    Widget inActive = Container(
        padding: EdgeInsets.all(15), child: Center(child: Text("$label")));

    return Expanded(
        flex: 1,
        child: GestureDetector(
            onTap: () => {this.trigger(this.label)},
            child: this.currentState == this.label ? active : inActive));
  }
}

class ChangePostType extends StatelessWidget {
  ChangePostType();

  @override
  Widget build(BuildContext context) {
    Map data = context.watch<CentralState>().data;
    Function update = context.read<CentralState>().update;
    String currentType = "Rent";

    if (data["preference-postType"] != null) {
      currentType = data["preference-postType"];
    }

    void changeCurrentPostType(String newType) {
      update("preference-postType", newType);
    }

    return Container(
      width: double.infinity,
      child: Row(children: [
        TypeButton(changeCurrentPostType, currentType, "Rent"),
        TypeButton(changeCurrentPostType, currentType, "Donate"),
        TypeButton(changeCurrentPostType, currentType, "Sell"),
        TypeButton(changeCurrentPostType, currentType, "Used")
      ]),
    );
  }
}
