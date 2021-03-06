// Copyright 2019 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import '../CentralState.dart';
import 'package:provider/provider.dart';
import "./Spinner.dart";
import '../controllers/Global.dart' as globals;
import 'package:flutter_svg/flutter_svg.dart';

final String assetName = 'assets/userOnMap.svg';
final Widget userOnMap =
    SvgPicture.asset(assetName, semanticsLabel: 'userOnMap ');

class TheImage extends StatelessWidget {
  TheImage(this.latitude, this.longitude, [this.smaller = 0]);

  final String latitude;
  final String longitude;
  final int smaller;

  Widget build(BuildContext context) {
    final String lat = this.latitude;
    final String long = this.longitude;
    final mediaQuery = MediaQuery.of(context);

    final mapToken = globals.env["mapboxToken"];

    final String image =
        "https://api.mapbox.com/styles/v1/mapbox/streets-v11/static/$long,$lat,13,0.00,0.00/1000x600@2x?access_token=$mapToken";

    return Container(
      width: double.infinity,
      height: (mediaQuery.size.height - 250 - smaller - mediaQuery.padding.top),
      decoration: BoxDecoration(),
      child: Image.network(image, fit: BoxFit.cover),
    );
  }
}

class RenderLocation extends StatelessWidget {
  RenderLocation(this.latitude, this.longitude, [this.smaller = 0]);

  final String latitude;
  final String longitude;
  final int smaller;

  @override
  Widget build(BuildContext context) {
    if (this.latitude == "") return Text("invalid GPS");

    print("gps showng");

    final mediaQuery = MediaQuery.of(context);

    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(25)),
      child: Container(
        width: double.infinity,
        height:
            (mediaQuery.size.height - 250 - smaller - mediaQuery.padding.top),
        decoration: BoxDecoration(),
        child: Stack(children: [
          TheImage(latitude, longitude, smaller),
          Align(
              child: Container(
                padding: EdgeInsets.all(50),
                child: userOnMap,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(59, 59, 59, 0.16),
                    borderRadius: BorderRadius.circular(500)),
              ),
              alignment: Alignment.center)
        ]),
      ),
    );
  }
}
