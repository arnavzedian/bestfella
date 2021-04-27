import "package:flutter/material.dart";
import "../StringExtension.dart";
import 'package:intl/intl.dart';

class RenderTypeAndTags extends StatelessWidget {
  RenderTypeAndTags(
    this.type,
    this.tags,
    this.itemData,
  );
  final Map itemData;
  final String tags;
  final String type;

  @override
  Widget build(BuildContext context) {
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

    String price = '';
    List<Widget> allItems = [];

    if (itemData["price"] != null) price = itemData["price"].toString();

    String editedType = this.type;
    if (editedType == "donate") editedType = "donation";
    editedType = editedType.capitalize();

    Widget hashtag(tag) {
      return Container(
        decoration: BoxDecoration(

            // color: Colors.black,
            borderRadius: BorderRadius.circular(5)),
        child: Text(tag, style: TextStyle(color: Colors.grey.shade700)),
        padding: EdgeInsets.fromLTRB(0, 4, 7, 4),
      );
    }

    if (price != "") {
      allItems.add(hashtag(formatIt(price)));
    } else {
      allItems.add(hashtag("#Free"));
    }

    allItems.add(hashtag("#$editedType"));

    List<String> allTags = tags.split(" ");

    for (String key in allTags) {
      allItems.add(hashtag(key));
    }

    return Column(
      children: [
        Wrap(direction: Axis.horizontal, runSpacing: 0, children: allItems),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
