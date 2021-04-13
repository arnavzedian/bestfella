import "package:flutter/material.dart";

class DetailPageMainButton extends StatelessWidget {
  DetailPageMainButton(this.icon, this.txt, this.onTap);
  final Widget icon;
  final String txt;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    var center = new Center(
      child: Row(children: [
        icon,
        SizedBox(
          width: 10,
        ),
        Text(
          txt,
          style: new TextStyle(fontSize: 15.0, color: Colors.black26),
        )
      ]),
    );

    return GestureDetector(
      onTap: () => {onTap()},
      child: Column(children: [
        SizedBox(height: 10),
        Expanded(
            flex: 1,
            child: Container(
              // width: 100.0,
              padding: EdgeInsets.fromLTRB(20, 7, 20, 7),
              // height: 30.0,
              decoration: new BoxDecoration(
                color: Colors.grey[50],
                border: new Border.all(color: Colors.black26, width: 2.0),
                borderRadius: new BorderRadius.circular(10.0),
              ),
              child: center,
            ))
      ]),
    );
  }
}
