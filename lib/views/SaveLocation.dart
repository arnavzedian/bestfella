import "package:flutter/material.dart";
import '../CentralState.dart';
import 'package:provider/provider.dart';
import '../widgets/TakeTextInput.dart';
import "../widgets/SaveButton.dart";
import "../widgets/RenderLocation.dart";
import "../widgets/Spinner.dart";
import 'package:geolocator/geolocator.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
  void getCurrentLocation(Function setLocation) async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(position.latitude);

    setLocation("questioned-latitude", position.latitude.toString());
    setLocation("questioned-longitude", position.longitude.toString());
  }

  @override
  void initState() {
    var state = Provider.of<CentralState>(context, listen: false);
    getCurrentLocation(state.update);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map data = context.watch<CentralState>().data;
    Function saveLocalStorage = context.read<CentralState>().saveLocalStorage;

    if (data["questioned-latitude"] == null) return Spinner();
    final String latitude = data["questioned-latitude"];
    final String longitude = data["questioned-longitude"];

    return Stack(children: [
      RenderLocation(latitude, longitude),
      SaveButton(() {
        saveLocalStorage('preference-longitude', longitude);
        saveLocalStorage('preference-latitude', latitude);

        Fluttertoast.showToast(
            msg: "Your location is saved",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        //  Navigator.pushNamed(context, '/home');
      }),
    ]);
  }
}

class SaveLocation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black87),
            shadowColor: Colors.grey[50],
            title: Text(
              'Save GPS',
              style: TextStyle(color: Colors.black87),
            ),
            backgroundColor: Colors.grey[200]),
        body: SafeArea(
            child: Container(
                padding: EdgeInsets.fromLTRB(25, 25, 25, 0),
                child: MainBody())));
  }
}
