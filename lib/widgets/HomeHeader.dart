import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';
import '../CentralState.dart';
import 'package:provider/provider.dart';

final String assetName = 'assets/logo.svg';
final Widget logo = SvgPicture.asset(assetName, semanticsLabel: 'Logo Button');

class CityButton extends StatelessWidget {
  CityButton();

  @override
  Widget build(BuildContext context) {
    Map data = context.watch<CentralState>().data;
    String city = data["city"];
    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/save-city-name');
        },
        child: Container(
          // width: 100.0,
          padding: EdgeInsets.fromLTRB(20, 7, 20, 7),
          // height: 30.0,
          decoration: new BoxDecoration(
            color: Colors.grey[50],
            border: new Border.all(color: Colors.black26, width: 2.0),
            borderRadius: new BorderRadius.circular(10.0),
          ),
          child: new Center(
            child: new Text(
              'City: $city',
              style: new TextStyle(fontSize: 15.0, color: Colors.black26),
            ),
          ),
        ));
  }
}

class HomeHeader extends StatelessWidget {
  HomeHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Container(child: logo), CityButton()]);
  }
}
