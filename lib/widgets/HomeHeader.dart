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
    return ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
            decoration:
                BoxDecoration(border: Border.all(color: Colors.blueAccent)),
            padding: EdgeInsets.all(5),
            child: Text("city:darbhanga")));
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
