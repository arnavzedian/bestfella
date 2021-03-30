import "package:flutter/material.dart";
import "../CentralState.dart";
import 'package:provider/provider.dart';

class BottomButton extends StatelessWidget {
  BottomButton({required this.txt, required this.callback});

  final String txt;
  final Function callback;
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => {callback()},
        child: Container(
          margin: EdgeInsets.all(25),
          padding: EdgeInsets.all(25),
          height: 75,
          width: 75,
          child: Text(txt,
              textAlign: TextAlign.center, style: TextStyle(fontSize: 20)),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(500),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
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
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        BottomButton(txt: "+ Donate", callback: gotoMakeDonation),
        BottomButton(txt: "🏠", callback: gotoHome),
        BottomButton(txt: "🧿", callback: gotoProfile)
      ]),
    );
  }
}
