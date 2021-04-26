import "package:flutter/material.dart";
import "../StringExtension.dart";

class RenderTypeAndTags extends StatelessWidget {
  RenderTypeAndTags(
    this.type,
    this.tags,
  );

  final String tags;
  final String type;

  @override
  Widget build(BuildContext context) {
    List<Widget> allItems = [];

    String editedType = this.type;
    if (editedType == "donate") editedType = "donation";
    editedType = editedType.capitalize();

    allItems.add(Container(
      decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: Colors.black,
            style: BorderStyle.solid,
          ),
          // color: Colors.black,
          borderRadius: BorderRadius.circular(5)),
      child: Text(editedType, style: TextStyle(color: Colors.black)),
      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
      margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
    ));

    List<String> allTags = tags.split(" ");

    for (String key in allTags) {
      allItems.add(Container(
          padding: EdgeInsets.fromLTRB(0, 5, 5, 5), child: Text(key)));
    }

    return Wrap(
        direction: Axis.horizontal, runSpacing: 5.0, children: allItems);
  }
}
