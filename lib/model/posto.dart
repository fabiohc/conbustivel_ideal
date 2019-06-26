class Posto {
  int id;
  String nomePosto;
  String gasolinaPreco;
  String alcoolPreco;
  String tipoCombustivel;
  DateTime dataConsulta;

  Posto();

  Posto.fromMap(Map map) {
    id = map["p_id"];
    nomePosto = map["p_nomePosto"];
    gasolinaPreco = map["p_gasolinaPreco"];
    alcoolPreco = map["p_alcoolPreco"];
    tipoCombustivel = map["p_tipoCombustivel"];
    dataConsulta = map["p_dataConsulta"];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      "p_id": id,
      "p_nomePosto": nomePosto,
      "p_gasolinaPreco": gasolinaPreco,
      "p_alcoolPreco": alcoolPreco,
      "p_tipoCombustivel": tipoCombustivel,
      "p_dataConsulta": dataConsulta,
    };
    if (id != null) {
      map["p_id"] = id;
    }
    return map;
  }

  @override
  String toString() {
    return "Posto[ id: $id,"
        "nomePosto: $nomePosto"
        "gasolinaPreco: $gasolinaPreco"
        "String alcoolPreco: $alcoolPreco"
        "String tipoCombustivel: $tipoCombustivel"
        "DateTime dataConsulta : $dataConsulta"
        "]";
  }
}
