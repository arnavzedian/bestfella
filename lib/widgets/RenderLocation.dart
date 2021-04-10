// Copyright 2019 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import '../CentralState.dart';
import 'package:provider/provider.dart';
import "./Spinner.dart";
import '../controllers/Global.dart' as globals;

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
        "https://api.mapbox.com/styles/v1/mapbox/streets-v11/static/$long,$lat,9.67,0.00,0.00/1000x600@2x?access_token=$mapToken";

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
              child: Text(
                "♥",
                style: TextStyle(fontSize: 25, color: Colors.black),
              ),
              alignment: Alignment.center)
        ]),
      ),
    );
  }
}
