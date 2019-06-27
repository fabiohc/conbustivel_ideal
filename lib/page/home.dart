import 'package:conbustivel_ideal/helper/Posto_Helper.dart';
import 'package:conbustivel_ideal/model/posto.dart';
import 'package:conbustivel_ideal/page/historico.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  @override

  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double valorGasolina = 0.0;
  double valorAlcool = 0.0;
  TextEditingController _nomePostoController = TextEditingController();
  TextEditingController _precoGasolina = TextEditingController();
  TextEditingController _precoAlcool = TextEditingController();
  TextEditingController _dataRegistro = TextEditingController();

  PostoHelper helper = PostoHelper();
  Posto posto = Posto();

  @override
  void _showPostoPage({Posto posto}) async {
    final regPosto = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HistoricoPage(posto: posto)),
    );
  }

  void _gravaDadosPosto({Posto posto}) async {
    if (posto != null) {
      await helper.insert(posto);
    }
  }

  Widget buildAppBar() {
    return AppBar(
      title: Text("Combustivel Ideal"),
      backgroundColor: Colors.black,
      centerTitle: true,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.arrow_forward),
          onPressed: () {
            _showPostoPage();
          },
        )
      ],
    );
  }

  Widget buildRaisedButton(Posto posto) {
    return RaisedButton(
      child: Text("Verificar"),
      color: Colors.black,
      shape: OutlineInputBorder(),
      textColor: Colors.white,
      padding: EdgeInsets.fromLTRB(140.0, 20.0, 140.0, 20.0),
      onPressed: () {
        double resultDif = posto.alcoolPreco % posto.gasolinaPreco;
        String mensagem = "";
        if (resultDif >= 0.7) {
          mensagem =
          "O abastecimento com GASOLINA é mais vantajoso nesse posto";
        } else {
          mensagem = "O abastecimento com ALCOOL é mais vantajoso nesse posto";
        }
        posto.dataConsulta = DateTime.now();
        _gravaDadosPosto(posto: posto);
        _ApresenteMelhorOpcao(context, mensagem);
      },
    );
  }

  MoneyMaskedTextController buildMoneyMaskedTextController(
      TextEditingController campo) {
    return new MoneyMaskedTextController(
        decimalSeparator: ',', thousandSeparator: '.');
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
                labelText: "Nome do Posto",
                labelStyle: TextStyle(color: Colors.black, fontSize: 20.0),
                border: OutlineInputBorder(),
              ),
              controller: _nomePostoController,
              onChanged: (value) {
                posto.nomePosto = value;
              },
            ),
            Divider(),
            TextField(
              decoration: InputDecoration(
                labelText: "Preço do gasolina",
                labelStyle: TextStyle(color: Colors.black, fontSize: 20.0),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              controller: buildMoneyMaskedTextController(_precoGasolina),
              onChanged: (value) {
                try {
                  posto.gasolinaPreco = double.parse(value);
                } catch (ex) {
                  posto.gasolinaPreco = 0.0;
                }
              },
            ),
            Divider(),
            TextField(
              controller: buildMoneyMaskedTextController(_precoAlcool),
              decoration: InputDecoration(
                labelText: "Preço do alcool",
                labelStyle: TextStyle(color: Colors.black, fontSize: 20.0),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onChanged: (value) {
                try {
                  posto.alcoolPreco = double.parse(value);
                } catch (ex) {
                  posto.alcoolPreco = 0.0;
                }
              },
            ),
            Divider(),
            Container(
              child: buildRaisedButton(posto),
            ),
          ],
        ),
      ),
    );
  }

  void _ApresenteMelhorOpcao(BuildContext context, String mensagem) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            title: Text("Resultado"),
            content: Text(mensagem),
            actions: <Widget>[
              FlatButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.pop(context);
                  })
            ]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildScaffold();
  }
  void iniState() {
    super.initState();
  }

}
