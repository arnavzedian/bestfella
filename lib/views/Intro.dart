import "package:flutter/material.dart";
import '../CentralState.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../controllers/Auth.dart';

final String assetName = 'assets/logo.svg';
final Widget logo = SvgPicture.asset(assetName, semanticsLabel: 'Logo ');

final String assetName2 = 'assets/google.svg';
final Widget google =
    SvgPicture.asset(assetName2, semanticsLabel: 'Google logo');
// class TodoItem {
//   String item;
//   TodoItem(String item) {
//     this.item = item;
//   }
// }

const Widget DonationHeader = Text(
  'Rent . Donate . Sell',
  style: TextStyle(
      color: Colors.black87, fontSize: 30.0, fontWeight: FontWeight.bold),
);

class HeroText extends StatelessWidget {
  HeroText(this.opacity);
  final double opacity;
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: this.opacity,
      child: DonationHeader,
    );
  }
}

class LoginWithGoogle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Function saveLocalStorage = context.watch<CentralState>().saveLocalStorage;
    Function update = context.read<CentralState>().update;

    void attemptSignIn() async {
      try {
        update("loading-signin", true);
        String? cookie = await Auth.signIn();
        update("loading-signin", false);
        if (cookie != null) saveLocalStorage("cookie", cookie);
      } catch (enError) {
        update("error", enError);
      }
    }

    return GestureDetector(
        onTap: attemptSignIn,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Container(
                margin: const EdgeInsets.all(15.0),
                padding: const EdgeInsets.all(20.0),
                decoration: new BoxDecoration(
                  color: Colors.grey[50],
                  border: new Border.all(color: Colors.black, width: 2.0),
                  borderRadius: new BorderRadius.circular(200.0),
                ),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  google,
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "Login with google",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  )
                ]))));
  }
}

class MainBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      SingleChildScrollView(
          child: Column(children: [
        SizedBox(
          height: 50.0,
        ),
        logo,
        SizedBox(
          height: 30.0,
        ),
        HeroText(1),
        HeroText(0.8),
        HeroText(0.5),
        SizedBox(
          height: 10.0,
        ),
        SizedBox(
          height: 300.0,
        ),
      ])),
      Positioned(child: LoginWithGoogle())
    ]);
  }
}

class Intro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
                padding: EdgeInsets.fromLTRB(25, 25, 25, 0),
                child: MainBody())));
  }
}
