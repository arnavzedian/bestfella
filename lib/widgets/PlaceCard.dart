import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';
import '../CentralState.dart';
import 'package:provider/provider.dart';
import '../classes/ScreenArguments.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PlaceCard extends StatelessWidget {
  PlaceCard([this.city = "", this.state = "", this.country = ""]);
  //'https://placeimg.com/640/480/any'
  final String city;
  final String state;
  final String country;

  @override
  Widget build(BuildContext context) {
    Function saveLocalStorage = context.read<CentralState>().saveLocalStorage;

    void gotoDetailsPage() {
      Fluttertoast.showToast(
          msg: "Your location is saved",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);

      saveLocalStorage("preference-city", city);
      saveLocalStorage("preference-state", state);
      saveLocalStorage("preference-country", country);
    }

    return Column(children: [
      SizedBox(
        height: 25,
      ),
      GestureDetector(
          onTap: gotoDetailsPage,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(25, 15, 25, 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                width: 2,
                color: Colors.black,
                style: BorderStyle.solid,
              ),
            ),
            child: Center(child: Text("$city, $state, $country")),
          ))
    ]);
  }
}
