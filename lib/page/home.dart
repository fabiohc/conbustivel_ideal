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

  TextField _nomePostoController = TextField();
  TextField _precoGasolina = TextField();
  TextField _precoAlcool = TextField();
  TextField _dataRegistro = TextField();

  PostoHelper helper = PostoHelper();

  @override
  void iniState() {
    super.initState();

    /* Posto posto00 = Posto();
    posto00.nomePosto = "Nome do posto00";
    posto00.tipoCombustivel = "Comum";
    posto00.gasolinaPreco = "487";
    posto00.alcoolPreco = "2970";
    posto00.dataConsulta = DateTime.now();
    helper.insert(posto00);*/
  }

  void _showPostoPage({Posto posto}) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HistoricoPage(posto: posto)),
    );
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

  Widget buildRaisedButton() {
    return RaisedButton(
      child: Text("Verificar"),
      color: Colors.black,
      shape: OutlineInputBorder(),
      textColor: Colors.white,
      padding: EdgeInsets.fromLTRB(140.0, 20.0, 140.0, 20.0),
      onPressed: () {
        double resultDif = valorAlcool % valorGasolina;
        String mensagem = "";
        if (resultDif >= 0.7) {
          mensagem =
              "O abastecimento com GASOLINA é mais vantajoso nesse posto";
        } else {
          mensagem = "O abastecimento com ALCOOL é mais vantajoso nesse posto";
        }
        _ApresenteMelhorOpcao(context, mensagem);
      },
    );
  }

  MoneyMaskedTextController buildMoneyMaskedTextController() {
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
            ),
            Divider(),
            TextField(
              decoration: InputDecoration(
                labelText: "Preço do gasolina",
                labelStyle: TextStyle(color: Colors.black, fontSize: 20.0),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              controller: buildMoneyMaskedTextController(),
              onChanged: (value) {
                try {
                  valorGasolina = double.parse(value);
                } catch (ex) {
                  valorGasolina = 0.0;
                }
              },
            ),
            Divider(),
            TextField(
              controller: buildMoneyMaskedTextController(),
              decoration: InputDecoration(
                labelText: "Preço do alcool",
                labelStyle: TextStyle(color: Colors.black, fontSize: 20.0),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                BlacklistingTextInputFormatter(new RegExp('[\\-|\\ ]'))
              ],
              onChanged: (value) {
                try {
                  valorAlcool = double.parse(value);
                } catch (ex) {
                  valorAlcool = 0.0;
                }
              },
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
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildScaffold();
  }
}
