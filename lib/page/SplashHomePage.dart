import 'package:flutter/material.dart';
import 'home.dart';

class SplashHomePage extends StatefulWidget {
  @override
  _SplashHomePageState createState() => _SplashHomePageState();
}

class _SplashHomePageState extends State<SplashHomePage> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3)).then((_) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => Home()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
              decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/images/logo.png")),
          )),
        ],
      ),
    );
  }
}
