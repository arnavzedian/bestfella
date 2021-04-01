import "package:flutter/material.dart";
import '../CentralState.dart';
import 'package:provider/provider.dart';

class TakeTextInput extends StatefulWidget {
  TakeTextInput(this.placeholder,
      {this.takeNumber = false, this.initialValue = ""});
  final String placeholder;
  final String initialValue;
  final bool takeNumber;

  @override
  _TakeTextInputState createState() => _TakeTextInputState();
}

class _TakeTextInputState extends State<TakeTextInput> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Function update = context.read<CentralState>().update;

    return Container(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: TextField(
          keyboardType:
              widget.takeNumber == false ? null : TextInputType.number,
          onChanged: (val) {
            update(widget.placeholder, val);
          },
          decoration: InputDecoration(hintText: widget.placeholder),
        ));
  }
}
