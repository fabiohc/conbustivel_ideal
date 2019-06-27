import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:conbustivel_ideal/model/posto.dart';

class PostoHelper {
  static final PostoHelper _instance = PostoHelper.internal();

  PostoHelper.internal();

  factory PostoHelper() => _instance;

  Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return db;
  }

  Future<Database> initDb() async {
    final path = await getDatabasesPath();
    final pathDB = join(path, "posto.db");

    final String sql = "CREATE TABLE posto ("
        "p_id INTEGER PRIMARY KEY,"
        "p_nomePosto TEXT,"
        "gasolinaPreco FLOAT,"
        "alcoolPreco FLOAT,"
        "tipoCombustivel TEXT,"
        "dataConsulta DATETIME"
        ")";

    return await openDatabase(pathDB, version: 1,
        onCreate: (Database db, int newerVersion) async {
          await db.execute(sql);
        });
  }

  Future<Posto> insert(Posto posto) async {
    Database dbPosto = await db;
    posto.id = await dbPosto.insert("posto", posto.toMap());
    return posto;
  }

  Future<Posto> selectById(int id) async {
    Database dbPosto = await db;
    List<Map> maps = await dbPosto.query("posto",
        columns: [
          "p_id",
          "p_nomePosto",
          "p_gasolinaPreco",
          "p_alcoolPreco",
          "p_tipoCombustivel",
          "p_dataConsulta"
        ],
        where: "p_id = ?",
        whereArgs: [id]);
    if (maps.length > 0) {
      return Posto.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<List> selectAll() async {
    Database dbPosto = await db;
    List list = await dbPosto.rawQuery("Select * from posto");
    List<Posto> lsPosto = List();
    for (Map m in list) {
      lsPosto.add(Posto.fromMap(m));
    }
    return lsPosto;
  }

  Future<int> update(Posto posto) async {
    Database dbPosto = await db;
    return await dbPosto.update("posto", posto.toMap(),
        where: "p_id = ?", whereArgs: [posto.id]);
  }

  Future<int> delete(int id) async {
    Database dbPosto = await db;
    return await dbPosto.delete("posto", where: "p_id = ?", whereArgs: [id]);
  }

  Future close() async {
    Database dbPosto = await db;
    dbPosto.close();
  }
}
