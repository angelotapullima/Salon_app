import 'package:flutter/foundation.dart';
import 'package:salon_app/src/database/databd_config.dart';
import 'package:salon_app/src/models/alumno_model.dart';
import 'package:sqflite/sqlite_api.dart';

class AlumnoDatabase {
  final dbprovider = DatabaseHelper.instance;

  Future<void> insertarAlumno(AlumnoModel alumno) async {
    try {
      final Database db = await dbprovider.getDatabase();

      await db.insert(
        'Alumno',
        alumno.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      if (kDebugMode) {
        print("$e Error en la tabla Alumno");
      }
    }
  }

  Future<List<AlumnoModel>> getAlumnos(String idAula) async {
    try {
      final Database db = await dbprovider.getDatabase();
      List<AlumnoModel> list = [];
      List<Map> maps = await db.rawQuery("SELECT * FROM Alumno where idAula = '$idAula' and alumnoEstado = '1' ");

      if (maps.isNotEmpty) list = AlumnoModel.fromJsonList(maps);
      return list;
    } catch (e) {
      if (kDebugMode) {
        print(" $e Error en la  tabla Alumno");
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
