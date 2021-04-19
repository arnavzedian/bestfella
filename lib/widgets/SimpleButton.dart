import "package:flutter/material.dart";

class SimpleButton extends StatelessWidget {
  SimpleButton(this.txt, this.onTap);
  final String txt;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {onTap()},
      child: Column(children: [
        SizedBox(height: 10),
        Container(
          // width: 100.0,
          padding: EdgeInsets.fromLTRB(20, 7, 20, 7),
          // height: 30.0,
          decoration: new BoxDecoration(
            color: Colors.grey[50],
            border: new Border.all(color: Colors.black54, width: 1.0),
            borderRadius: new BorderRadius.circular(10.0),
          ),
          child: new Center(
            child: new Text(
              txt,
              style: new TextStyle(fontSize: 13.0, color: Colors.black54),
            ),
          ),
        )
      ]),
    );
  }
}
