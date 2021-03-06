import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';
import '../CentralState.dart';
import 'package:provider/provider.dart';
import "../classes/ScreenArguments.dart";
import '../StringExtension.dart';
import "./AdditionalData.dart";
import "./RenderTypeAndTags.dart";

class InfoPart extends StatelessWidget {
  InfoPart(this.itemData, [this.title = "", this.tags = "", this.type = ""]);
  final String title;
  final Map itemData;
  final String tags;
  final String type;

  @override
  Widget build(BuildContext context) {
    String editedTitle = this.title.capitalize();
    String editedType = this.type;
    if (editedType == "donate") editedType = "donation";
    editedType = editedType.capitalize();
    return Container(
        padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: 25,
          ),
          Text(
            editedTitle,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          RenderTypeAndTags(this.type, this.tags, itemData),
          SizedBox(
            height: 25,
          )
        ]));
  }
}

class DonationImage extends StatelessWidget {
  DonationImage([this.image = ""]);
  //'https://placeimg.com/640/480/any'
  final String image;

  @override
  Widget build(BuildContext context) {
    if (image == "") return Text("invalid image");
    print("rendering card");
    if (this.image.indexOf(".jpg") == -1) return Text("bad image");

    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Image.network(image, fit: BoxFit.cover),
    );
  }
}

class DonationCard extends StatelessWidget {
  DonationCard(this.itemData);
  //'https://placeimg.com/640/480/any'
  final Map<String, dynamic> itemData;

//
  @override
  Widget build(BuildContext context) {
    Function updateWithoutRefresh =
        context.read<CentralState>().updateWithoutRefresh;

    void gotoDetailsPage() {
      updateWithoutRefresh("item-image", itemData['image']);
      updateWithoutRefresh("item-title", itemData['title']);
      updateWithoutRefresh("item-tags", itemData['tags']);
      updateWithoutRefresh("item-id", itemData['_id']);
      updateWithoutRefresh("item-donater", itemData['donater']);
      updateWithoutRefresh("item-stock", itemData['stock']);
      updateWithoutRefresh("item-type", itemData['type']);
      updateWithoutRefresh("item-price", itemData['price']);
      updateWithoutRefresh("item-period", itemData['period']);
      updateWithoutRefresh("item-security", itemData['security']);
      updateWithoutRefresh("deletePost", null);
      updateWithoutRefresh("item-latitude", itemData['latitude'].toString());
      updateWithoutRefresh("item-longitude", itemData['longitude'].toString());

      Navigator.pushNamed(
        context,
        '/donation-details',
      );
    }

    return Column(children: [
      SizedBox(
        height: 25,
      ),
      GestureDetector(
          onTap: gotoDetailsPage,
          child: Container(
            // decoration: BoxDecoration(
            //   color: Colors.white,
            //   borderRadius: BorderRadius.circular(14),
            //   border: Border.all(
            //     width: 1,
            //     color: Colors.grey.shade400,
            //     style: BorderStyle.solid,
            //   ),
            // ),
            child: Wrap(children: [
              DonationImage(itemData['image']),
              InfoPart(itemData, itemData['title'], itemData['tags'],
                  itemData['type']),
            ]),
          ))
    ]);
  }
}
