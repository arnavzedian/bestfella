import "package:flutter/material.dart";
import '../CentralState.dart';
import 'package:provider/provider.dart';
import '../widgets/TakeTextInput.dart';
import "../widgets/SaveButton.dart";
import "../widgets/Spinner.dart";
// class TodoItem {
//   String item;
//   TodoItem(String item) {
//     this.item = item;
//   }
// }

class MainBody extends StatefulWidget {
  @override
  _MainBodyState createState() => _MainBodyState();
}

class _MainBodyState extends State<MainBody> {
  @override
  Widget build(BuildContext context) {
    Function load = context.watch<CentralState>().load;
    Function update = context.watch<CentralState>().update;
    Map data = context.watch<CentralState>().data;

    if (data["loading-savePhoneNumber"] != null) {
      if (data["loading-savePhoneNumber"] == true) Spinner();
    }

    return SingleChildScrollView(
        child: Column(children: [
      TakeTextInput("Phone Number", takeNumber: true),
      SaveButton(() {
        if (data["Phone Number"] != null) {
          final Map<String, dynamic> body = {
            "phoneNumber": data["Phone Number"]
          };

          void callback() {
            update("phoneNumber", data["Phone Number"]);
          }

          load("savePhoneNumber", "/phone-number",
              body: body, method: "POST", callback: callback);
        }
      }),
    ]));
  }
}

class SavePhoneNumber extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            child: Container(
                padding: EdgeInsets.fromLTRB(25, 25, 25, 0),
                child: MainBody())));
  }
}
