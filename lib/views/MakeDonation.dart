import "package:flutter/material.dart";
import '../CentralState.dart';
import 'package:provider/provider.dart';
import "../widgets/TakeTextInput.dart";
import "../widgets/SaveButton.dart";
import "../widgets/Spinner.dart";
import "./SaveLocation.dart";
import "./SavePhoneNumber.dart";
import "../widgets/Loading.dart";
import "../widgets/ImageUploader.dart";
// class TodoItem {
//   String item;
//   TodoItem(String item) {
//     this.item = item;
//   }SaveButton
// }

class MainBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Map data = context.watch<CentralState>().data;
    Function load = context.read<CentralState>().load;

    Map<String, dynamic> body = {
      "title": data["Title"],
      "tags": data["Tags"],
      "image": data["uploadedImage"],
      "GPS": data["GPS"],
      "city": data["city"],
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

    List<Widget> allWidgets = [
      ImageUploader(),
      SizedBox(height: 30),
      TakeTextInput("Title"),
      SizedBox(height: 30),
      TakeTextInput("Tags"),
    ];

    if (data["Title"] != null &&
        data["Tags"] != null &&
        data["uploadedImage"] != null) {
      allWidgets.add(SaveButton(save));
    }

    allWidgets.add(SizedBox(
      height: 50,
    ));

    return SingleChildScrollView(child: Column(children: allWidgets));
  }
}

class MakeDonation extends StatefulWidget {
  @override
  _MakeDonationState createState() => _MakeDonationState();
}

class _MakeDonationState extends State<MakeDonation> {
  @override
  void initState() {
    super.initState();
    var state = Provider.of<CentralState>(context, listen: false);
    state.clearData("phoneNumber");
    state.clearData("Title");
    state.clearData("Tags");
    state.clearData("uploadedImage");
    state.load("phoneNumber", "/phone-number");
  }

  @override
  Widget build(BuildContext context) {
    Map data = context.watch<CentralState>().data;

    if (data["loading-phoneNumber"] != null) {
      if (data["loading-phoneNumber"] == true) return Loading();
    }
    if (data["phoneNumber"] == null) return SavePhoneNumber();
    if (data["GPS"] == null) return SaveLocation();
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
