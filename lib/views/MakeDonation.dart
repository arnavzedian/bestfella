import "package:flutter/material.dart";
import '../CentralState.dart';
import 'package:provider/provider.dart';
import "../widgets/TakeTextInput.dart";
import "../widgets/SaveButton.dart";
import "../widgets/Spinner.dart";
import "./SaveLocation.dart";
import "./SavePhoneNumber.dart";
import "../widgets/Loading.dart";
import '../widgets/TypeSpecificFields.dart';
import '../widgets/ChangePostType.dart';

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

    String period = "weekly";
    if (data["dropdown-period"] != null) period = data["dropdown-period"];
    Map<String, dynamic> body = {
      "title": data["Title"],
      "tags": data["Tags"],
      "image": data["uploadedImage"],
      "latitude": data["preference-latitude"],
      "longitude": data["preference-longitude"],
      "city": data["preference-city"],
      "stock": data["Stock"],
      "type": data["preference-postType"],
      "period": period,
      "securityAmount": data["Security Amount"],
      "price": data["Price"],
      "state": data["preference-state"],
      "country": data["preference-country"],
    };

    void save() {
      load("makeDonation", "/donation",
          body: body, method: "POST", source: "notInitState");
    }

    if (data["loading-makeDonation"] != null) {
      if (data["loading-makeDonation"] == true) Spinner();
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
            "Your post is now live",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
          )
        ]),
      );
    }

    List<Widget> allWidgets = [
      ChangePostType(),
      SizedBox(height: 30),
      ImageUploader(),
      SizedBox(height: 30),
      TakeTextInput("Title"),
      TakeTextInput("Tags"),
      TypeSpecificFields()
    ];

    void ifAvailable(List<String> items, Function callback) {
      bool shouldAllow = true;
      items.forEach((element) {
        if (data[element] == null) {
          shouldAllow = false;
          //  print(data[element]);
          print("$element not defined");
        }
      });
      if (shouldAllow == true) callback();
    }

    String postType = "Rent";

    if (data["preference-postType"] != null) {
      postType = data["preference-postType"];
    }

    void allowSaveButton() {
      allWidgets.add(SaveButton(save));
    }

    ifAvailable(["Title", "Tags", "uploadedImage"], () {
      if (postType == "Rent") {
        ifAvailable(["Security Amount", "Price"], allowSaveButton);
      } else if (postType == "Donate") {
        allowSaveButton();
      } else if (postType == "Sell") {
        ifAvailable(["Price"], allowSaveButton);
      } else if (postType == "Used") {
        ifAvailable(["Price"], allowSaveButton);
      }
    });

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
    state.clearData("Stock");
    state.clearData("Period");
    state.clearData("Price");
    state.clearData("Security Amount");

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
    if (data["preference-latitude"] == null) return SaveLocation();
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
