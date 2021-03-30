import "package:flutter/material.dart";
import '../CentralState.dart';
import 'package:provider/provider.dart';
import '../widgets/TakeTextInput.dart';
// class TodoItem {
//   String item;
//   TodoItem(String item) {
//     this.item = item;
//   }
// }

class SaveButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(height: 50),
          Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(50, 15, 50, 15),
              decoration: new BoxDecoration(
                color: Colors.black,
                border: new Border.all(color: Colors.black54, width: 2.0),
                borderRadius: new BorderRadius.circular(20.0),
              ),
              child: Text(
                'Save',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.normal),
              )),
        ],
      ),
    );
  }
}
