import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';
import '../CentralState.dart';
import 'package:provider/provider.dart';
import '../controllers/Auth.dart';
import 'SimpleButton.dart';
import 'Spinner.dart';

class GetDonaterName extends StatefulWidget {
  GetDonaterName();

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<GetDonaterName> {
  @override
  void initState() {
    super.initState();
    var state = Provider.of<CentralState>(context, listen: false);
    state.clearData("item-donaterName");
    String donationID = state.data["item-id"];
    state.load("item-donaterName", "/donater-name",
        body: {"donationID": donationID});
  }

  @override
  Widget build(BuildContext context) {
    Map data = context.read<CentralState>().data;

    String theName = "";

    if (data["loading-item-donaterName"] != null) {
      if (data["loading-item-donaterName"] == true) {
        return Text("Loading..");
      }
    }

    if (data["item-donaterName"] != null) {
      theName = data["item-donaterName"];
    }

    return Text("Posted by $theName");
  }
}
