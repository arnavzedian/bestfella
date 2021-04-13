import "package:flutter/material.dart";
import '../CentralState.dart';
import 'package:provider/provider.dart';
import '../StringExtension.dart';

class AdditionalData extends StatelessWidget {
  AdditionalData(this.itemData, [this.prefix = ""]);
  final Map itemData;
  final String prefix;
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
          fieldName = fieldName.replaceAll(prefix, "");
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
    doCheckingAndAdd(prefix + "stock");
    doCheckingAndAdd(prefix + "securityAmount");
    doCheckingAndAdd(prefix + "price");

    doCheckingAndAdd(prefix + "period");
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start, children: widgets);
  }
}
