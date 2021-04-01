import 'dart:js';

import "package:flutter/material.dart";
import '../CentralState.dart';
import 'package:provider/provider.dart';
import '../widgets/BottomBar.dart';
import '../controllers/Global.dart' as globals;
import '../widgets/Spinner.dart';

// class TodoItem {
//   String item;
//   TodoItem(String item) {
//     this.item = item;
//   }
// }

const Widget DonationHeader = Text(
  'Profile',
  style: TextStyle(
      color: Colors.black87, fontSize: 40.0, fontWeight: FontWeight.bold),
);

class CustomButton extends StatelessWidget {
  CustomButton(this.txt, this.onTap);
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
            border: new Border.all(color: Colors.black26, width: 2.0),
            borderRadius: new BorderRadius.circular(10.0),
          ),
          child: new Center(
            child: new Text(
              txt,
              style: new TextStyle(fontSize: 15.0, color: Colors.black26),
            ),
          ),
        )
      ]),
    );
  }
}

class DonationInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map data = context.watch<CentralState>().data;

    final String image = data["image"] == null ? "" : data["image"];
    final String title = data["title"] == null ? "" : data["title"];
    final String tags = data["tags"] == null ? "" : data["tags"];

    final String loaderName = "requestPhoneNumber";
    if (data["loading-$loaderName"] != null) {
      if (data["loading-$loaderName"] == true) {
        return Spinner();
      }
    }
    return Column(
      children: [
        Container(
            width: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      height: 130,
                      color: Colors.grey[350],
                      width: 130,
                      child: Image.network(
                        image,
                        fit: BoxFit.cover,
                      ),
                    )),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 25.0,
                            fontWeight: FontWeight.normal)),
                    SizedBox(height: 5),
                    Text(tags),
                  ],
                ),
              ],
            )),
        SizedBox(height: 50)
      ],
    );
  }
}

class MainBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map data = context.watch<CentralState>().data;
    final String id = data["id"] == null ? "" : data["id"];
    final Function load = context.watch<CentralState>().load;

    void callback(phoneNumber) {
      globals.showDialog?.call("Number", phoneNumber);
    }

    void requestPhoneNumber() {
      Map body = {"donationID": id};
      load("requestPhoneNumber", "/request-phone-number",
          body: body, callback: callback);
    }

    return Padding(
        padding: EdgeInsets.all(30),
        child: SingleChildScrollView(
            child: Column(children: [
          DonationInfo(),
          Text("Render gps"),
          Row(
            children: [
              CustomButton("Get direction", () {}),
              CustomButton("Request phone number", () => requestPhoneNumber())
            ],
          )
        ])));
  }
}

class DonationDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black87),
            shadowColor: Colors.grey[50],
            title: Text(
              'Details',
              style: TextStyle(color: Colors.black87),
            ),
            backgroundColor: Colors.grey[200]),
        body: SafeArea(child: MainBody()));
  }
}
