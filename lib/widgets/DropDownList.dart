import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';
import '../CentralState.dart';
import 'package:provider/provider.dart';

class DropDownList extends StatelessWidget {
  DropDownList(this.label, this.options);
  final String label;
  final List<String> options;
  @override
  Widget build(BuildContext context) {
    Map data = context.watch<CentralState>().data;
    Function update = context.read<CentralState>().update;

    String currentOption = options[0];

    if (data["dropdown-$label"] != null) {
      currentOption = data["dropdown-$label"];
    }

    return Column(children: [
      DropdownButton<String>(
        isExpanded: true,
        value: currentOption,
        icon: const Icon(Icons.keyboard_arrow_down_rounded),
        iconSize: 24,
        elevation: 16,
        style: const TextStyle(color: Colors.black),
        underline: Container(
          height: 2,
          color: Colors.grey,
        ),
        onChanged: (String? newValue) {
          update("dropdown-$label", newValue);
        },
        items: options.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
      SizedBox(
        height: 20,
      )
    ]);
  }
}
