import "package:flutter/material.dart";
import "./DonationCard.dart";
import "../CentralState.dart";
import 'package:provider/provider.dart';
import "./Spinner.dart";

class RenderCards extends StatefulWidget {
  RenderCards(this.type);
  final String type;

  @override
  _RenderCardsState createState() => _RenderCardsState();
}

class _RenderCardsState extends State<RenderCards> {
  String? donationType;
  @override
  void initState() {
    var state = Provider.of<CentralState>(context, listen: false);

    Map<String, dynamic> body = {"basis": "donater"};
    if (widget.type == "feeds") {
      body = {"basis": "city", "value": state.data["city"]};
    }

    String basis = body["basis"];
    donationType = "donations-$basis";
    state.clearData("$donationType");

    state.load("$donationType", "/donations", body: body);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Map data = context.watch<CentralState>().data;

    if (data["loading-$donationType"] != null) {
      if (data["loading-$donationType"] == true) return Spinner();
    }

    if (data["$donationType"] == null) return Text("data not loaded");

    final List list = data["$donationType"];

    String city = data['city'];
    if (list.length == 0)
      return Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Text("Be the first to make a donation in your city $city"),
        ],
      );

    return Column(children: [
      Column(
          children: list.map((item) {
        // Map itemData = item.cast<String, dynamic>();
        // print(itemData);
        // return Text(itemData["title"]);
        return DonationCard(
            item["image"], item["title"], item["tags"], item["_id"]);
      }).toList()),
      SizedBox(
        height: 100,
      )
    ]);
  }
}
