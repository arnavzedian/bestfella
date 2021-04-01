import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';
import '../CentralState.dart';
import 'package:provider/provider.dart';
import "../classes/ScreenArguments.dart";

class DonationCard extends StatelessWidget {
  DonationCard(this.image, this.title, this.tags, this.id);
  //'https://placeimg.com/640/480/any'
  final String image;
  final String title;
  final String tags;
  final String id;

  @override
  Widget build(BuildContext context) {
    Function change = context.read<CentralState>().change;

    void gotoDetailsPage() {
      change("image", image);
      change("title", title);
      change("tags", tags);
      change("id", id);

      Navigator.pushNamed(context, '/donation-details',
          arguments: ScreenArguments(image, title, tags, id));
    }

    return GestureDetector(
        onTap: gotoDetailsPage,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              width: 2,
              color: Colors.black,
              style: BorderStyle.solid,
            ),
            image: DecorationImage(
              image: AssetImage(image),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(children: [
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            SizedBox(
              height: 25,
            ),
            Text(tags)
          ]) /* add child content here */,
        ));
  }
}
