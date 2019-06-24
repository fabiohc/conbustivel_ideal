import 'package:flutter/material.dart';
import 'dart:io';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Widget buildAppBar() {
    return AppBar(
      title: Text("Combustivel Ideal"),
      backgroundColor: Colors.black,
      centerTitle: true,
    );
  }

  Widget buildRaisedButton() {
    return RaisedButton(
      child: Text("Verificar"),
      color: Colors.black,
      shape: OutlineInputBorder(),
      textColor: Colors.white,
      padding: EdgeInsets.fromLTRB(140.0, 20.0, 140.0, 20.0),
      onPressed: () {},
    );
  }

  Widget buildScaffold() {
    return Scaffold(
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Divider(),
            TextField(
              decoration: InputDecoration(
                labelText: "Posto",
                labelStyle: TextStyle(color: Colors.black, fontSize: 20.0),
                border: OutlineInputBorder(),
              ),
            ),
            Divider(),
            TextField(
              decoration: InputDecoration(
                labelText: "Preço do gasolina",
                labelStyle: TextStyle(color: Colors.black, fontSize: 20.0),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            Divider(),
            Divider(),
            TextField(
              decoration: InputDecoration(
                labelText: "Preço do alcool",
                labelStyle: TextStyle(color: Colors.black, fontSize: 20.0),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            Divider(),
            Container(

              child: buildRaisedButton(),

            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildScaffold();
  }
}
