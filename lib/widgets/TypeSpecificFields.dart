import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';
import '../CentralState.dart';
import 'package:provider/provider.dart';
import '../classes/ScreenArguments.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'TakeTextInput.dart';
import 'DropDownList.dart';

class TypeSpecificFields extends StatelessWidget {
  TypeSpecificFields();

  @override
  Widget build(BuildContext context) {
    Map data = context.watch<CentralState>().data;
    Function update = context.watch<CentralState>().update;

    String currentType = "Rent";

    if (data["preference-postType"] != null) {
      currentType = data["preference-postType"];
    }

    List<Widget> inputWidgets = [];

    Widget isUsedCheckBox = ListTileTheme(
        contentPadding: EdgeInsets.all(0),
        child: CheckboxListTile(
          // isThreeLine: true,
          title: Text("Is used"),
          value: data["isUsed-checkBox"],
          onChanged: (newValue) {
            update("isUsed-checkBox", newValue);
          },
          controlAffinity:
              ListTileControlAffinity.leading, //  <-- leading Checkbox
        ));

    if (currentType == "Rent") {
      inputWidgets.add(TakeTextInput(
          "security (to be returned at the end of rent)",
          label: "security",
          takeNumber: true));
      inputWidgets.add(DropDownList(
          "period", ["weekly", "daily", "monthly", "quaterly", "yearly"]));
      inputWidgets.add(TakeTextInput("Price", takeNumber: true));
    } else if (currentType == "Sell") {
      inputWidgets.add(TakeTextInput("Price", takeNumber: true));
      inputWidgets.add(isUsedCheckBox);
      // inputWidgets.add(TakeTextInput("Stock", takeNumber: true));
    }
    return Container(
      width: double.infinity,
      child: Column(children: inputWidgets),
    );
  }
}
