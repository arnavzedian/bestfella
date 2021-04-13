import "package:flutter/material.dart";
import '../CentralState.dart';
import 'package:provider/provider.dart';
import '../StringExtension.dart';

class AdditionalData extends StatelessWidget {
  AdditionalData(this.itemData);
  final Map itemData;

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];

    void doCheckingAndAdd(String name) {
      if (itemData[name] != null) {
        if (itemData[name] != "") {
          String fieldName = name;
          if (fieldName == "securityAmount") {
            fieldName = "Security Amount";
          }
          fieldName = fieldName.capitalize().trim();
          String value = itemData[name].toString();
          value = value.capitalize();
          widgets.add(Text("$fieldName : $value"));
          widgets.add(SizedBox(
            height: 10,
          ));
        }
      }
    }

    // doCheckingAndAdd("type");
    doCheckingAndAdd("stock");
    doCheckingAndAdd("securityAmount");
    doCheckingAndAdd("price");

    doCheckingAndAdd("period");
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start, children: widgets);
  }
}
