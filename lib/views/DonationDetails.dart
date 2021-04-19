import 'package:bestfella/widgets/Loading.dart';
import "package:flutter/material.dart";
import '../CentralState.dart';
import 'package:provider/provider.dart';
import '../widgets/BottomBar.dart';
import '../controllers/Global.dart' as globals;
import '../widgets/Spinner.dart';
import '../widgets/renderLocation.dart';
import '../widgets/GetDonaterName.dart';
import '../widgets/RenderTypeAndTags.dart';
import '../widgets/AdditionalData.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/DetailPageMainButton.dart';
import '../widgets/SimpleButton.dart';
import '../StringExtension.dart';

final String assetName = 'assets/map.svg';
final Widget mapSVG = SvgPicture.asset(assetName, semanticsLabel: 'mapSVG ');

final String assetName2 = 'assets/call.svg';
final Widget callSVG = SvgPicture.asset(assetName2, semanticsLabel: 'callSVG ');

const Widget DonationHeader = Text(
  'Profile',
  style: TextStyle(
      color: Colors.black87, fontSize: 40.0, fontWeight: FontWeight.bold),
);

class CustomButton extends StatelessWidget {
  CustomButton(this.txt, this.onTap, [this.width]);
  final String txt;
  final Function onTap;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {onTap()},
      child: Column(children: [
        SizedBox(height: 10),
        Container(
          width: width,
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
    final String type = data["item-type"] == null ? "" : data["item-type"];

    final String loaderName = "requestPhoneNumber";
    if (data["loading-$loaderName"] != null) {
      if (data["loading-$loaderName"] == true) {
        return Spinner();
      }
    }
    return Column(
      children: [
        SizedBox(
          height: 25,
        ),
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
                    Text(title.capitalize(),
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 25.0,
                            fontWeight: FontWeight.normal)),
                    SizedBox(height: 5),
                    RenderTypeAndTags(type, tags),
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

    void callback(int phoneNumber) {
      String number = phoneNumber.toString();
      globals.showDialog?.call("Number", number);
    }

    void requestPhoneNumber() {
      Map<String, dynamic> body = {"donationID": id};
      load(
        "requestPhoneNumber",
        "/request-phone-number",
        body: body,
        method: "POST",
        callback: callback,
      );
    }

    void deletePost() {
      Map<String, dynamic> body = {"donationID": id};
      load("deletePost", "/delete-donation",
          body: body, method: "POST", source: "notInitState");
    }

    if (data["loading-deletePost"] != null) {
      if (data["loading-deletePost"] == true) {
        return Loading();
      }
    }

    if (data["deletePost"] != null) {
      return Container(
          padding: EdgeInsets.all(5),
          child: Center(child: Text("Post has been deleted")));
    }

    String lat = data["item-latitude"];
    String long = data["item-longitude"];

    Widget deleteButton = SizedBox(
      height: 0,
    );

    if (data["userProfile"] != null) {
      if (data["userProfile"]["id"] == data["item-donater"]) {
        deleteButton = SimpleButton("Delete Post", () => deletePost());
      }
    }

    print(data["userProfile"]);
    print(data["item-donater"]);

    void openMap() async {
      String _url = 'https://maps.google.com/?q=$lat,$long';
      print(_url);
      launch(_url);
    }

    var mainButtons = Container(
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            DetailPageMainButton(mapSVG, "Open Map", openMap),
            DetailPageMainButton(callSVG, "Call", requestPhoneNumber)
          ],
        ));

    return Stack(children: [
      Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.fromLTRB(25, 0, 25, 25),
          child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                SizedBox(
                  height: 10,
                ),
                DonationInfo(),
                AdditionalData(data, "item-"),
                GetDonaterName(),
                SizedBox(height: 50),
                RenderLocation(
                    data["item-latitude"], data["item-longitude"], 150),
                SizedBox(height: 25),
                deleteButton,
                SizedBox(height: 100)
              ]))),
      Positioned(bottom: 0, left: 0, child: mainButtons)
    ]);
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
