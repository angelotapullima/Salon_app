

import 'package:flutter/foundation.dart';
import 'package:salon_app/src/database/databd_config.dart';
import 'package:salon_app/src/models/salon_tutor_model.dart';
import 'package:sqflite/sqlite_api.dart';

class AulaDatabase {
  final dbprovider = DatabaseHelper.instance;

  Future<void> insertarAula(AulaModel aula) async {
    try {
      final Database db = await dbprovider.getDatabase();

      await db.insert(
        'Aula',
        aula.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      if (kDebugMode) {
        print("$e Error en la tabla aula");
      }
    }
  }

  Future<List<AulaModel>> getAulas() async {
    try {
      final Database db = await dbprovider.getDatabase();
      List<AulaModel> list = [];
      List<Map> maps = await db.rawQuery("SELECT * FROM Aula where aulaEstado = '1' ");

      if (maps.isNotEmpty) list = AulaModel.fromJsonList(maps);
      return list;
    } catch (e) {
      if (kDebugMode) {
        print(" $e Error en la  tabla aulaEstado");
      }
      return [];
    }
  }/* 

  Future<List<CategoriaModel>> getCategoriaById(String idCategoria) async {
    try {
      final Database db = await dbprovider.getDatabase();
      List<CategoriaModel> list = [];
      List<Map> maps = await db.rawQuery("SELECT * FROM Categoria WHERE idCategoria='$idCategoria' AND estadoCategoria = '1' ");

      if (maps.length > 0) list = CategoriaModel.fromJsonList(maps);
      return list;
    } catch (e) {
      print(" $e Error en la  tabla Categoria");
      return [];
    }
  }

   */deleteAula() async {
    final db = await dbprovider.database;

    final res = await db.rawDelete("DELETE FROM Aula");

    return res;
  }
}
