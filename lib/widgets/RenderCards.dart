import "package:flutter/material.dart";
import "./DonationCard.dart";
import "../CentralState.dart";
import 'package:provider/provider.dart';
import "./Spinner.dart";
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class RenderCards extends StatefulWidget {
  RenderCards(this.type);
  final String type;

  @override
  _RenderCardsState createState() => _RenderCardsState();
}

class _RenderCardsState extends State<RenderCards> {
  String? donationType;
  Map<String, dynamic> body = {"basis": "donater"};
  Function? loader;
  Future<void> refresh() async {
    await loader?.call("$donationType", "/donations", body: body);
    return null;
  }

  @override
  void initState() {
    var state = Provider.of<CentralState>(context, listen: false);
    loader = state.load;
    if (widget.type == "feeds") {
      body = {"basis": "city", "value": state.data["preference-city"]};
    }

    String basis = body["basis"];
    donationType = "donations-$basis";
    state.clearData("$donationType");
    this.refresh();
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
          Text("Be the first donater in $city"),
        ],
      );

    const List<StaggeredTile> _staggeredTiles = <StaggeredTile>[];
    const List<Widget> tiles = [];

    list.map((item) {
      tiles.add(DonationCard(item));
      _staggeredTiles.add(StaggeredTile.count(2, 2));
    });

    return RefreshIndicator(
        onRefresh: this.refresh,
        child: StaggeredGridView.countBuilder(
            // shrinkWrap: true,
            //
            itemCount: list.length,
            crossAxisCount: 2,
            crossAxisSpacing: 4,
            mainAxisSpacing: 4,
            staggeredTileBuilder: (int index) => new StaggeredTile.fit(1),
            itemBuilder: (BuildContext context, int index) {
              return DonationCard(list[index]);
            }));

    // return RefreshIndicator(
    //   onRefresh: this.refresh,
    //   child: Column(children: [
    //     Column(
    //         children: list.map((item) {
    //       // Map itemData = item.cast<String, dynamic>();
    //       // print(itemData);
    //       // return Text(itemData["title"]);
    //       //
    //       print(item);
    //       //
    //       // if (item["image"] == null) item["image"] = "";

    //       // if (item["stock"] == null) item["stock"] = "";
    //       // if (item["type"] == null) item["type"] = "";
    //       // if (item["period"] == null) item["period"] = "";
    //       // if (item["price"] == null) item["price"] = "";
    //       // if (item["securityAmount"] == null) item["securityAmount"] = "";

    //       // if (item["title"] == null) item["title"] = "";
    //       // if (item["tags"] == null) item["tags"] = "";
    //       // if (item["_id"] == null) item["_id"] = "";
    //       // if (item["donater"] == null) item["donater"] = "";

    //       // if (item["latitude"] == null) {
    //       //   item["latitude"] = "";
    //       // } else {
    //       //   item["latitude"] = item["latitude"].toString();
    //       // }
    //       // if (item["longitude"] == null) {
    //       //   item["longitude"] = "";
    //       // } else {
    //       //   item["longitude"] = item["longitude"].toString();
    //       // }

    //       return DonationCard(item);
    //     }).toList()),
    //     SizedBox(
    //       height: 100,
    //     )
    //   ]),
    // );
  }
}
