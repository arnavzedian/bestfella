import "package:flutter/material.dart";
import "./DonationCard.dart";
import "../CentralState.dart";
import 'package:provider/provider.dart';
import "./Spinner.dart";
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class RenderCards extends StatefulWidget {
  RenderCards(this.type, this.headerWidget);
  final String type;
  final Widget headerWidget;
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
          widget.headerWidget,
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
            itemCount: list.length + 1,
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            staggeredTileBuilder: (int index) {
              if (index == 0) return StaggeredTile.fit(2);
              return new StaggeredTile.fit(1);
            },
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) return widget.headerWidget;
              return DonationCard(list[index - 1]);
            }));
  }
}
