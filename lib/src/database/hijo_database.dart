import 'package:flutter/foundation.dart';
import 'package:salon_app/src/database/databd_config.dart';
import 'package:salon_app/src/models/alumno_model.dart';
import 'package:sqflite/sqlite_api.dart';

class HijoDatabase {
  final dbprovider = DatabaseHelper.instance;

  Future<void> insertarHijo(AlumnoModel hijo) async {
    try {
      final Database db = await dbprovider.getDatabase();

      await db.insert(
        'Hijo',
        hijo.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      if (kDebugMode) {
        print("$e Error en la tabla Hijo");
      }
    }
  }

  Future<List<AlumnoModel>> getHijos() async {
    try {
      final Database db = await dbprovider.getDatabase();
      List<AlumnoModel> list = [];
      List<Map> maps = await db.rawQuery("SELECT * FROM Hijo where  alumnoEstado = '1' ");

      if (maps.isNotEmpty) list = AlumnoModel.fromJsonList(maps);
      return list;
    } catch (e) {
      if (kDebugMode) {
        print(" $e Error en la  tabla Hijo");
      }
      return [];
    }
  }


  deleteHijos() async {
    final db = await dbprovider.database;

    final res = await db.rawDelete("DELETE FROM Hijo");

    return res;
  }
}
