import 'package:flutter/material.dart';
import '../CentralState.dart';
import 'package:provider/provider.dart';
import '../controllers/Auth.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Function removeLocalStorage =
        context.read<CentralState>().removeLocalStorage;

    return ElevatedButton(
      child: const Text('SIGN OUT'),
      onPressed: () async {
        await Auth.signOut();
        removeLocalStorage("cookie");
        removeLocalStorage("gps");
        removeLocalStorage("city");
      },
    );
  }
}

/*

class GreenFrog extends StatelessWidget {
  const GreenFrog({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(color: const Color(0xFF2DBD3A));
  }
}

*/
