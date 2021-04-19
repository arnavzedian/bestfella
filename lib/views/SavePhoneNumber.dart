import "package:flutter/material.dart";
import '../CentralState.dart';
import 'package:provider/provider.dart';
import '../widgets/TakeTextInput.dart';
import "../widgets/SaveButton.dart";
import "../widgets/Spinner.dart";
import "../widgets/CustomPadding.dart";
import '../controllers/Global.dart' as globals;
// class TodoItem {
//   String item;
//   TodoItem(String item) {
//     this.item = item;
//   }
// }

class MainBody extends StatelessWidget {
  Widget build(BuildContext context) {
    return TakeTextInput("Phone Number", takeNumber: true);
  }
}

class SavePhoneNumber extends StatefulWidget {
  @override
  _SavePhoneNumberState createState() => _SavePhoneNumberState();
}

class _SavePhoneNumberState extends State<SavePhoneNumber> {
  @override
  Widget build(BuildContext context) {
    Function load = context.read<CentralState>().load;
    Function update = context.read<CentralState>().update;
    Map data = context.watch<CentralState>().data;

    if (data["loading-savePhoneNumber"] != null) {
      if (data["loading-savePhoneNumber"] == true) return Spinner();
    }

    var container = CustomPadding(MainBody());

    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black87),
            shadowColor: Colors.grey[50],
            title: Text(
              'Save Phone Number',
              style: TextStyle(color: Colors.black87),
            ),
            backgroundColor: Colors.grey[200]),
        body: SafeArea(
            child: Stack(children: [
          container,
          SaveButton(() {
            if (data["Phone Number"] != null) {
              String number = data["Phone Number"].toString();
              if (number.length < 10)
                return globals.showDialog
                    ?.call("Oops", "Number should be atleast 10 digit long");
              final Map<String, dynamic> body = {
                "phoneNumber": data["Phone Number"]
              };

              void callback(bool success) {
                update("phoneNumber", data["Phone Number"]);
              }

              load("savePhoneNumber", "/phone-number",
                  body: body, method: "POST", callback: callback);
            }
          })
        ])));
  }
}
