import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';
import '../CentralState.dart';
import 'package:provider/provider.dart';
import "../classes/ScreenArguments.dart";
import '../StringExtension.dart';
import "./AdditionalData.dart";

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
        padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: 25,
          ),
          Text(
            editedTitle,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(5)),
                child: Text(editedType, style: TextStyle(color: Colors.white)),
                padding: EdgeInsets.all(5),
              ),
              SizedBox(
                width: 10,
              ),
              Text(tags),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          AdditionalData(itemData),
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
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(14), topRight: Radius.circular(14)),
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

      updateWithoutRefresh("item-stock", itemData['stock']);
      updateWithoutRefresh("item-type", itemData['type']);
      updateWithoutRefresh("item-price", itemData['price']);
      updateWithoutRefresh("item-period", itemData['period']);
      updateWithoutRefresh("item-securityAmount", itemData['securityAmount']);

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
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                width: 2,
                color: Colors.black,
                style: BorderStyle.solid,
              ),
            ),
            child: Wrap(children: [
              DonationImage(itemData['image']),
              InfoPart(itemData, itemData['title'], itemData['tags'],
                  itemData['type']),
            ]),
          ))
    ]);
  }
}
