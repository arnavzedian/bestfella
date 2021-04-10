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
      body = {"basis": "city", "value": state.data["preference-city"]};
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

    String city = data['preference-city'];
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
        //
        //
        if (item["image"] == null) item["image"] = "";
        if (item["title"] == null) item["title"] = "";
        if (item["tags"] == null) item["tags"] = "";
        if (item["_id"] == null) item["_id"] = "";
        if (item["latitude"] == null) {
          item["latitude"] = "";
        } else {
          item["latitude"] = item["latitude"].toString();
        }
        if (item["longitude"] == null) {
          item["longitude"] = "";
        } else {
          item["longitude"] = item["longitude"].toString();
        }

        return DonationCard(item["image"], item["title"], item["tags"],
            item["_id"], item["latitude"], item["longitude"]);
      }).toList()),
      SizedBox(
        height: 100,
      )
    ]);
  }
}
