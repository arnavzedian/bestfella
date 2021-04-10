import "package:flutter/material.dart";
import './PlaceCard.dart';
import '../CentralState.dart';
import 'package:provider/provider.dart';
import 'Spinner.dart';

Widget loadingSpinner = Column(children: [SizedBox(height: 50), Spinner()]);

class RenderPlaces extends StatefulWidget {
  @override
  _RenderCardsState createState() => _RenderCardsState();
}

class _RenderCardsState extends State<RenderPlaces> {
  @override
  Widget build(BuildContext context) {
    final Map data = context.watch<CentralState>().data;

    if (data["loading-searchCity"] != null) {
      if (data["loading-searchCity"] == true) return loadingSpinner;
    }

    print(data);
    if (data["searchCity"] == null) return loadingSpinner;

    var item = data["searchCity"];

    String typedCityName =
        data['Search your city'] == null ? "" : data['Search your city'];
    if (item["features"] == null)
      return Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Text("No City Found with the name $typedCityName"),
        ],
      );

    List<dynamic> features = item["features"];

    String placeName = "";
    String city = "";
    String state = "";
    String country = "";
    for (var place in features) {
      List placeType = place["place_type"];
      if (placeType.indexOf("place") != -1) placeName = place["place_name"];
    }

    if (placeName == "") return Text("city not found");
    List<String> placeArray = placeName.split(",");
    if (placeArray.length != 3) return Text("place not found");
    city = placeArray[0];
    state = placeArray[1];
    country = placeArray[2];

    return PlaceCard(city, state, country);
  }
}
