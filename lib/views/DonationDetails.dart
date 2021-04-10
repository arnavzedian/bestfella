import "package:flutter/material.dart";
import '../CentralState.dart';
import 'package:provider/provider.dart';
import '../widgets/BottomBar.dart';
import '../controllers/Global.dart' as globals;
import '../widgets/Spinner.dart';
import '../widgets/renderLocation.dart';
import 'package:url_launcher/url_launcher.dart';
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
          padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
          // height: 30.0,
          decoration: new BoxDecoration(
            color: Colors.grey[50],
            border: new Border.all(color: Colors.black87, width: 2.0),
            borderRadius: new BorderRadius.circular(25.0),
          ),
          child: new Center(
            child: new Text(
              txt,
              style: new TextStyle(fontSize: 15.0, color: Colors.black87),
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

    final String image = data["item-image"] == null ? "" : data["item-image"];
    final String title = data["item-title"] == null ? "" : data["item-title"];
    final String tags = data["item-tags"] == null ? "" : data["item-tags"];

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
                      height: 70,
                      color: Colors.grey[350],
                      width: 70,
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
    final String id = data["item-id"] == null ? "" : data["item-id"];
    final Function load = context.read<CentralState>().load;

    void callback(phoneNumber) {
      globals.showDialog?.call("Number", phoneNumber);
    }

    void requestPhoneNumber() {
      Map body = {"donationID": id};
      load("requestPhoneNumber", "/request-phone-number",
          body: body, callback: callback);
    }

    String lat = data["item-latitude"];
    String long = data["item-longitude"];

    return Padding(
        padding: EdgeInsets.all(30),
        child: SingleChildScrollView(
            child: Column(children: [
          DonationInfo(),
          RenderLocation(data["item-latitude"], data["item-longitude"], 150),
          SizedBox(height: 25),
          Row(
            children: [
              CustomButton("Get direction", () async {
                String _url = 'https://maps.google.com/?q=$lat,$long';
                print(_url);
                launch(_url);
              }),
              SizedBox(width: 15),
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
