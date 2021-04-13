// Copyright 2019 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../CentralState.dart';
import './Spinner.dart';

class ImageUploader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Map data = context.watch<CentralState>().data;
    Function selectImage = context.read<CentralState>().selectImage;

    Widget widgetToShow = Text("upload image");

    if (data["uploadingImage"] == true)
      widgetToShow = CircularProgressIndicator();

    // print(data["uploadedImage"]);

    if (data["uploadedImage"] != null)
      widgetToShow = Image.network(data["uploadedImage"],
          height: 300, width: double.infinity, fit: BoxFit.cover);

    return GestureDetector(
        onTap: () => selectImage(),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey.shade900,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              height: 300,
              width: double.infinity,
              child: widgetToShow),
        ));
  }
}
