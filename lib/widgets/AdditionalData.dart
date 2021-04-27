import "package:flutter/material.dart";
import '../CentralState.dart';
import 'package:provider/provider.dart';
import '../StringExtension.dart';
import 'package:intl/intl.dart';

class AdditionalData extends StatelessWidget {
  AdditionalData(this.itemData, [this.prefix = ""]);
  final Map itemData;
  final String prefix;
  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];

    String formatIt(String val) {
      Locale locale = Localizations.localeOf(context);
      var format = NumberFormat.simpleCurrency(locale: locale.toString());
      print("CURRENCY SYMBOL ${format.currencySymbol}"); // $
      print("CURRENCY NAME ${format.currencyName}"); // USD
      String symbol = format.currencySymbol;
      var formatter = NumberFormat('#,##,000');
      String num = formatter.format(int.parse(val));
      return "$symbol$num";
    }

    String runFormatIt(String field, String val) {
      field = field.toLowerCase();
      print(field);
      if (field != "price" && field != "security") return val;
      return formatIt(val);
    }

    void doCheckingAndAdd(String name) {
      if (itemData[name] != null) {
        if (itemData[name] != "") {
          String fieldName = name;

          fieldName = fieldName.replaceAll(prefix, "");
          fieldName = fieldName.capitalize().trim();
          String value = itemData[name].toString();
          value = value.capitalize();
          widgets.add(Wrap(
            direction: Axis.horizontal,
            children: [
              Text("$fieldName: "),
              Text(runFormatIt(fieldName, value),
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
            ],
          ));
          widgets.add(SizedBox(
            height: 10,
          ));
        }
      }
    }

    // doCheckingAndAdd("type");
    doCheckingAndAdd(prefix + "stock");
    doCheckingAndAdd(prefix + "security");
    // doCheckingAndAdd(prefix + "price");

    doCheckingAndAdd(prefix + "period");
    return Wrap(
        direction: Axis.horizontal,
        runSpacing: 10,
        spacing: 10,
        children: widgets);
  }
}
