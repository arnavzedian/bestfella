import "package:flutter/material.dart";
import '../CentralState.dart';
import 'package:provider/provider.dart';
import '../widgets/TakeTextInput.dart';
import "../widgets/RenderPlaces.dart";
import '../controllers/Global.dart' as globals;
import 'package:geolocator/geolocator.dart';
import "../widgets/CustomPadding.dart";
// final mapToken = globals.env["mapboxToken"];

// class TodoItem {
//   String item;
//   TodoItem(String item) {
//     this.item = item;
//   }
// }

class MainBody extends StatefulWidget {
  @override
  _MainBodyState createState() => _MainBodyState();
}

class _MainBodyState extends State<MainBody> {
  void search(Function load, query) {
    String? mapboxToken = globals.env["mapboxToken"];
    String _url =
        "https://api.mapbox.com/geocoding/v5/mapbox.places/$query.json?access_token=$mapboxToken";
    load("searchCity", _url, absolute: true);
  }

  //to do
  //  get geo location in init state
  // on keyup make req to search
  //  make a function to translate loaded data
  // if data exist render a list with a onlclick event
  // on clikc event will trigger a toast and a saveLocalstorage
  //
  //
  //
  void getCurrentLocation(Function searcher, Function loader) async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    String lat = position.latitude.toString();
    String long = position.longitude.toString();
    searcher(loader, "$long,$lat");

    print(position.latitude);
  }

  @override
  void initState() {
    var state = Provider.of<CentralState>(context, listen: false);
    getCurrentLocation(this.search, state.load);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Function load = context.read<CentralState>().load;
    void doSearcing(query) {
      search(load, query);
    }

    return SingleChildScrollView(
        child: Column(children: [
      TakeTextInput("Search your city", onChange: doSearcing),
      RenderPlaces()
    ]));
  }
}

class SaveCityName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black87),
            shadowColor: Colors.grey[50],
            title: Text(
              'Save City Name',
              style: TextStyle(color: Colors.black87),
            ),
            backgroundColor: Colors.grey[200]),
        body: SafeArea(child: CustomPadding(MainBody())));
  }
}
