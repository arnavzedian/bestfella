import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';
import '../CentralState.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  Profile();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(500),
        child: Row(
          children: [
            Card(
                child: Image.network(
                  'https://placeimg.com/640/480/any',
                  fit: BoxFit.fill,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 5,
                margin: EdgeInsets.all(10)),
            Text("Arnav Singh",
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold))
          ],
        ));
  }
}
