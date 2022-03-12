import 'package:flutter/foundation.dart';
import 'package:salon_app/src/database/databd_config.dart';
import 'package:salon_app/src/models/aviso_model.dart';
import 'package:sqflite/sqlite_api.dart';

class AvisosDatabase {
  final dbprovider = DatabaseHelper.instance;

  Future<void> insertarAviso(AvisoModel aviso) async {
    try {
      final Database db = await dbprovider.getDatabase();

      await db.insert(
        'Aviso',
        aviso.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      if (kDebugMode) {
        print("$e Error en la tabla Aviso");
      }
    }
  }

  //citaciones => IdTipoAviso = 1
  Future<List<AvisoModel>> getAvisos( String date,String tipoAviso) async {
    try {
      final Database db = await dbprovider.getDatabase();
      List<AvisoModel> list = [];
      List<Map> maps =
          await db.rawQuery("SELECT * FROM Aviso where IdTipoAviso = '$tipoAviso' and date(avisoFechaPactada) >= '$date' group by avisoFechaPactada ");

      if (maps.isNotEmpty) list = AvisoModel.fromJsonList(maps);
      return list;
    } catch (e) {
      if (kDebugMode) {
        print(" $e Error en la  tabla Alumno");
      }
      return [];
    }
  }


  Future<List<AvisoModel>> getAvisoByFecha(String date, String  idTipoAviso) async {
    try {
      final Database db = await dbprovider.getDatabase();
      List<AvisoModel> list = [];
      List<Map> maps = await db.rawQuery("SELECT * FROM Aviso WHERE avisoFechaPactada='$date' and idTipoAviso = '$idTipoAviso' ");

      if (maps.isNotEmpty) list = AvisoModel.fromJsonList(maps);
      return list;
    } catch (e) {
      if (kDebugMode) {
        print(" $e Error en la  tabla Alert");
      }
      return [];
    }
  }


  deleteCategoria() async {
    final db = await dbprovider.database;

    final res = await db.rawDelete("DELETE FROM Alumno");

    return res;
  }
}
