import "package:flutter/material.dart";
import "./DonationCard.dart";
import "../CentralState.dart";
import 'package:provider/provider.dart';

class RenderCards extends StatelessWidget {
  RenderCards(this.type);
  final String type;

  @override
  Widget build(BuildContext context) {
    final Map config = context.watch<CentralState>().config;

    final List list = config["donation-list"];

    return Column(
        children: list.map((_) {
      return DonationCard();
    }).toList());
  }
}
