import "package:flutter/material.dart";

class DetailPageMainButton extends StatelessWidget {
  DetailPageMainButton(this.icon, this.txt, this.onTap);
  final Widget icon;
  final String txt;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    var center = new Center(
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        icon,
        SizedBox(
          width: 10,
        ),
        Text(
          txt,
          style: new TextStyle(fontSize: 15.0, color: Colors.white),
        )
      ]),
    );

    var container = Container(
      height: 70,
      padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
      color: Colors.black,
      child: center,
    );
    return Expanded(
        flex: 1,
        child: GestureDetector(
          onTap: () => {onTap()},
          child: container,
        ));
  }
}
