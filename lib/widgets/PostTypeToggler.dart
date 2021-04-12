import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';
import '../CentralState.dart';
import 'package:provider/provider.dart';
import '../classes/ScreenArguments.dart';
import 'package:fluttertoast/fluttertoast.dart';
import "./TakeTextInput.dart";

class PostTypeToggler extends StatelessWidget {
  PostTypeToggler();

  @override
  Widget build(BuildContext context) {
    Map data = context.watch<CentralState>().data;

    String currentType = "Rent";

    if (data["preference-postType"] != null) {
      currentType = data["preference-postType"];
    }

    List<Widget> inputWidgets = [];

    if (currentType == "Rent") {
      inputWidgets.add(TakeTextInput(
          "Security Amount (to be retuned at the end of rent)",
          label: "Security Amount",
          takeNumber: true));
      inputWidgets.add(TakeTextInput("Period"));
      inputWidgets.add(TakeTextInput("Price/period", takeNumber: true));
    } else if (currentType == "Sell") {
      inputWidgets.add(TakeTextInput("Price", takeNumber: true));
      inputWidgets.add(TakeTextInput("Stock", takeNumber: true));
    } else if (currentType == "Sell Used") {
      inputWidgets.add(TakeTextInput("Price", takeNumber: true));
    }
    return Container(
      width: double.infinity,
      child: Column(children: inputWidgets),
    );
  }
}