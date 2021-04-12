import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';
import '../CentralState.dart';
import 'package:provider/provider.dart';
import '../classes/ScreenArguments.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TypeSpecificFields extends StatelessWidget {
  TypeSpecificFields();

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
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            width: 2,
            color: Colors.black,
            style: BorderStyle.solid,
          )),
      child: Row(children: [
        TypeButton(changeCurrentPostType, currentType, "Rent"),
        TypeButton(changeCurrentPostType, currentType, "Donate"),
        TypeButton(changeCurrentPostType, currentType, "Sell")
      ]),
    );
  }
}
