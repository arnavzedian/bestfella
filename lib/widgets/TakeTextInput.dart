import "package:flutter/material.dart";
import '../CentralState.dart';
import 'package:provider/provider.dart';

class TakeTextInput extends StatelessWidget {
  TakeTextInput(this.placeholder);
  final String placeholder;
  @override
  Widget build(BuildContext context) {
    Function update = context.read<CentralState>().update;

    return Container(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: TextField(
          onChanged: (val) {
            update(placeholder, val);
          },
          onSubmitted: (_) {},
          decoration: InputDecoration(hintText: placeholder),
        ));
  }
}
