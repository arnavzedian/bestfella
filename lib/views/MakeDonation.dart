import "package:flutter/material.dart";
import '../CentralState.dart';
import 'package:provider/provider.dart';
import "../widgets/TakeTextInput.dart";
import "../widgets/SaveButton.dart";
import "../widgets/Spinner.dart";
// class TodoItem {
//   String item;
//   TodoItem(String item) {
//     this.item = item;
//   }SaveButton
// }

class MainBody extends StatefulWidget {
  @override
  _MainBodyState createState() => _MainBodyState();
}

class _MainBodyState extends State<MainBody> {
  @override
  void initState() {
    super.initState();
    var state = Provider.of<CentralState>(context, listen: false);

    state.clearData("makeDonation");
    state.update("image", null);
    state.update("title", null);
    state.update("tags", null);
  }

  @override
  Widget build(BuildContext context) {
    Map data = context.watch<CentralState>().data;
    Function load = context.watch<CentralState>().load;

    Map<String, dynamic> body = {
      "title": data["Title"],
      "tags": data["Tags"],
      "image": data["Image"]
    };

    void save() {
      load("makeDonation", "/donation", body: body, method: "get");
    }

    if (data["makeDonation"] != null) {
      return Center(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          SizedBox(height: 50),
          Text(
            "🙏 ",
            style: TextStyle(fontSize: 100),
          ),
          SizedBox(height: 25),
          Text(
            "Thankyou",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 15),
          Text(
            " your donation has been posted",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
          )
        ]),
      );
    }

    if (data["loading-makeDonation"] != null) {
      if (data["loading-makeDonation"] == true) Spinner();
    }

    return SingleChildScrollView(
        child: Column(children: [
      TakeTextInput("Title"),
      TakeTextInput("Image"),
      TakeTextInput("Tags"),
      SaveButton(save),
    ]));
  }
}

class MakeDonation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black87),
            shadowColor: Colors.grey[50],
            title: Text(
              'Make a donation',
              style: TextStyle(color: Colors.black87),
            ),
            backgroundColor: Colors.grey[200]),
        body: SafeArea(
            child: Container(
                padding: EdgeInsets.fromLTRB(25, 25, 25, 0),
                child: MainBody())));
  }
}
