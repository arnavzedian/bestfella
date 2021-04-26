import "package:flutter/material.dart";
import "../CentralState.dart";
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

final String assetName = 'assets/home.svg';
final Widget home = SvgPicture.asset(assetName, semanticsLabel: 'home ');

final String assetName1 = 'assets/profile.svg';
final Widget profile = SvgPicture.asset(assetName1, semanticsLabel: 'profile ');

final String assetName2 = 'assets/add.svg';
final Widget add = SvgPicture.asset(assetName2, semanticsLabel: 'add ');

class BottomButton extends StatelessWidget {
  BottomButton({required this.wid, required this.callback, this.txt: ""});

  final String txt;
  final Widget wid;
  final Function callback;
  @override
  Widget build(BuildContext context) {
    final Widget txtWidget = Container(
        margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
        child: Text(
          txt,
          style: TextStyle(
              color: Colors.black87,
              fontSize: 20.0,
              fontWeight: FontWeight.bold),
        ));

    return InkWell(
        onTap: () => {callback()},
        child: Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
          padding: EdgeInsets.all(15),
          height: 55,
          width: txt == "" ? 55 : null,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [wid, txt == "" ? SizedBox() : txtWidget]),
        ));
  }
}

class BottomBar extends StatelessWidget {
  BottomBar();

  @override
  Widget build(BuildContext context) {
    void gotoMakeDonation() {
      Navigator.pushNamed(context, '/make-donation');
    }

    // void gotoHome() {
    //   Navigator.pushNamed(context, '/home');
    // }

    void gotoProfile() {
      Navigator.pushNamed(context, '/profile');
    }

    var container = Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black38, width: 0.5),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(59, 59, 59, 0.5),
            blurRadius: 20,
            offset: Offset(0, 0), // Shadow position
          ),
        ],
      ),
      padding: EdgeInsets.fromLTRB(20, 2, 20, 2),
      // width: MediaQuery.of(context).size.width,
      child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        BottomButton(wid: add, callback: gotoMakeDonation, txt: "Post"),
        Container(
          margin: EdgeInsets.fromLTRB(10, 2, 10, 2),
          width: 1,
          height: 25,
          color: Colors.grey.shade700,
        ),
        BottomButton(wid: profile, callback: gotoProfile),
      ]),
    );
    return container;
  }
}
