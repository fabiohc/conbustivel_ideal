import 'package:conbustivel_ideal/helper/Posto_Helper.dart';
import 'package:conbustivel_ideal/model/posto.dart';
import 'package:flutter/cupertino.dart' as prefix1;
import 'package:flutter/material.dart';


class HistoricoPage extends StatefulWidget {
  @override
  final Posto posto;

  HistoricoPage({this.posto});

  _HistoricoPageState createState() => _HistoricoPageState();
}

class _HistoricoPageState extends State<HistoricoPage> {
  PostoHelper postoHelper = PostoHelper();

  List<Posto> lsPosto = List();

  Widget buildAppBar() {
    return AppBar(
      title: Text("Histórico"),
      backgroundColor: Colors.black,
      centerTitle: true,
    );
  }

  @override
  void initState() {
    super.initState();
    postoHelper.selectAll().then((list) {
      setState(() {
        lsPosto = list;
      });
    });
  }


  Widget buildContainerImagem(){
    return GestureDetector(
      child: Container(
        width: 140.0,
        height: 140.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: AssetImage("assets/images/bonba.png"),
            //fit:BoxFit.cover,
          ),
        ),
      ),
      onTap: () {
      },
    );
  }

  Widget buildCardHistorico(BuildContext context, int index) {
    return prefix1.GestureDetector(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Column(
                  children: <Widget>[
                buildContainerImagem(),
                    Text(
                      lsPosto[index].nomePosto ?? "-",
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      lsPosto[index].gasolinaPreco ?? "-",
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      lsPosto[index].alcoolPreco ?? "-",
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      lsPosto[index].dataConsulta ?? "-",
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildListView() {
    return ListView.builder(
        padding: EdgeInsets.all(10.0),
        itemCount: lsPosto.length,
        itemBuilder: (context, index) {
          return buildCardHistorico(context, index);
        });
  }

  Widget buildScaffold() {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildListView(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildScaffold();
  }
}
