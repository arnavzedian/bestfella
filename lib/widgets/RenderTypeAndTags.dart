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
    String editedType = this.type;
    if (editedType == "donate") editedType = "donation";
    editedType = editedType.capitalize();
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.black, borderRadius: BorderRadius.circular(5)),
          child: Text(editedType, style: TextStyle(color: Colors.white)),
          padding: EdgeInsets.all(5),
        ),
        SizedBox(
          width: 10,
        ),
        Text(tags),
      ],
    );
  }
}
