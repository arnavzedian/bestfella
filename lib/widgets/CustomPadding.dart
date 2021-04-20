// Copyright 2019 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

class CustomPadding extends StatelessWidget {
  CustomPadding(this.child);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.grey.shade100,
        padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: this.child);
  }
}
