import "package:flutter/material.dart";
import "../CentralState.dart";
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

final String assetName = 'assets/home.svg';
final Widget home = SvgPicture.asset(assetName, semanticsLabel: 'home ');

final String assetName1 = 'assets/profile.svg';
final Widget profile = SvgPicture.asset(assetName1, semanticsLabel: 'profile ');

final String assetName2 = 'assets/heart.svg';
final Widget heart = SvgPicture.asset(assetName2, semanticsLabel: 'heart ');

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
          margin: EdgeInsets.fromLTRB(25, 0, 0, 0),
          padding: EdgeInsets.all(15),
          height: 55,
          width: txt == "" ? 55 : null,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [wid, txt == "" ? SizedBox() : txtWidget]),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(59, 59, 59, 0.16),
                blurRadius: 4,
                offset: Offset(4, 8), // Shadow position
              ),
            ],
          ),
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

    void gotoHome() {
      Navigator.pushNamed(context, '/home');
    }

    void gotoProfile() {
      Navigator.pushNamed(context, '/profile');
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        BottomButton(wid: home, callback: gotoHome),
        BottomButton(wid: profile, callback: gotoProfile),
        BottomButton(wid: heart, callback: gotoMakeDonation, txt: "Donate"),
      ]),
    );
  }
}
