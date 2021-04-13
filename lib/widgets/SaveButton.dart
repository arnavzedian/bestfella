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
  SaveButton(this.callback);
  final Function callback;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      child: GestureDetector(
          onTap: () => {callback()},
          child: Container(
            width: MediaQuery.of(context).size.width,
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
                      borderRadius: new BorderRadius.circular(0.0),
                    ),
                    child: Text(
                      'Save',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold),
                    )),
              ],
            ),
          )),
    );
  }
}
