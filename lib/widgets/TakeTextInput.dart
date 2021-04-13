import "package:flutter/material.dart";
import '../CentralState.dart';
import 'package:provider/provider.dart';

void doNothing(String name) {}

class TakeTextInput extends StatefulWidget {
  TakeTextInput(
    this.placeholder, {
    this.label = "",
    this.onChange = doNothing,
    this.takeNumber = false,
    this.initialValue = "",
  });
  final String placeholder;
  final String label;
  final String initialValue;
  final bool takeNumber;
  final Function onChange;

  @override
  _TakeTextInputState createState() => _TakeTextInputState();
}

class _TakeTextInputState extends State<TakeTextInput> {
  // final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Function update = context.read<CentralState>().update;
    String label = widget.label;
    if (label == "") label = widget.placeholder;
    return Container(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
        margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
        child: TextField(
          keyboardType:
              widget.takeNumber == false ? null : TextInputType.number,
          onChanged: (val) {
            widget.onChange(val);
            update(label, val);
          },
          decoration: InputDecoration(hintText: widget.placeholder),
        ));
  }
}
