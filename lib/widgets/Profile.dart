import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';
import '../CentralState.dart';
import 'package:provider/provider.dart';
import '../controllers/Auth.dart';

import './Spinner.dart';

class ProfileButton extends StatelessWidget {
  ProfileButton(this.txt, this.onTap);
  final String txt;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {onTap()},
      child: Column(children: [
        SizedBox(height: 10),
        Container(
          // width: 100.0,
          padding: EdgeInsets.fromLTRB(20, 7, 20, 7),
          // height: 30.0,
          decoration: new BoxDecoration(
            color: Colors.grey[50],
            border: new Border.all(color: Colors.black26, width: 2.0),
            borderRadius: new BorderRadius.circular(10.0),
          ),
          child: new Center(
            child: new Text(
              txt,
              style: new TextStyle(fontSize: 15.0, color: Colors.black26),
            ),
          ),
        )
      ]),
    );
  }
}

class Profile extends StatefulWidget {
  Profile();

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
    var state = Provider.of<CentralState>(context, listen: false);
    state.clearData("userProfile");
    state.load("userProfile", "/profile");
  }

  @override
  Widget build(BuildContext context) {
    Function removeLocalStorage =
        context.read<CentralState>().removeLocalStorage;
    void logout() async {
      await Auth.signOut();
      removeLocalStorage("cookie");
      removeLocalStorage("gps");
      removeLocalStorage("city");
    }

    void gotoGPSedit() {
      Navigator.pushNamed(context, '/save-location');
    }

    void gotoNumberEdit() {
      Navigator.pushNamed(context, '/save-phone-number');
    }

    Map data = context.watch<CentralState>().data;

    if (data["loading-userProfile"] != null) {
      if (data["loading-userProfile"] == true) {
        return Spinner();
      }
    }

    print("userProfile");
    print(
      data['userProfile'],
    );

    if (data["userProfile"] == null) {
      return Text("data not loaded");
    }
    final String name = data["userProfile"]?["name"];
    final String picture = data["userProfile"]?["picture"];

    return Column(
      children: [
        Container(
            width: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      height: 130,
                      color: Colors.grey[350],
                      width: 130,
                      child: Image.network(
                        picture,
                        fit: BoxFit.cover,
                      ),
                    )),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name,
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 25.0,
                            fontWeight: FontWeight.normal)),
                    SizedBox(height: 5),
                    ProfileButton("Edit Phone number", gotoNumberEdit),
                    Row(children: [
                      ProfileButton("Edit GPS", gotoGPSedit),
                      SizedBox(width: 10),
                      ProfileButton("Logout", logout)
                    ])
                  ],
                ),
              ],
            )),
        SizedBox(height: 50)
      ],
    );
  }
}
