import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:salon_app/src/database/alumnos_database.dart';
import 'package:salon_app/src/database/aula_database.dart';
import 'package:salon_app/src/models/alumno_model.dart';
import 'package:salon_app/src/models/salon_tutor_model.dart';
import 'package:salon_app/src/preferencias/preferencias_usuario.dart';
import 'package:salon_app/src/utils/constants.dart';

class AulaApi {
  final aulaDatabase = AulaDatabase();
  final alumnoDatabase = AlumnoDatabase();
  final prefs = Preferences();
  
  Future<void> getAulas() async {
    try {
      final url = Uri.parse('$apiBaseURL/api/aviso/listar_aulas_responsable');

      final resp = await http.post(url, body: {
        'tn': prefs.token,
        'app': 'true',
      });

      final decodedData = json.decode(resp.body);

      for (var i = 0; i < decodedData['result']['aulas'].length; i++) {
        AulaModel aulaModel = AulaModel();

        aulaModel.idAula = decodedData['result']['aulas'][i]['id_aula'];
        aulaModel.aulaGrado = decodedData['result']['aulas'][i]['aula_grado'];
        aulaModel.aulaSeccion = decodedData['result']['aulas'][i]['aula_seccion'];
        aulaModel.aulaNivel = decodedData['result']['aulas'][i]['aula_nivel'];
        aulaModel.aulaEstado = decodedData['result']['aulas'][i]['aula_responsable_estado'];
        await aulaDatabase.insertarAula(aulaModel);

        var alumns = decodedData['result']['aulas'][i]['alumnos'];
        if (alumns.isNotEmpty) {
          for (var x = 0; x < alumns.length; x++) {
            AlumnoModel alumnoModel = AlumnoModel();

            alumnoModel.idAlumno = alumns[x]['id_alumno'];
            alumnoModel.idAula = alumns[x]['id_aula'];
            alumnoModel.alumnoNombre = alumns[x]['persona_nombre'];
            alumnoModel.alumnoApellido = '${alumns[x]['persona_apellido_paterno']} ${alumns[x]['persona_apellido_materno']}';
            alumnoModel.alumnoImagen = alumns[x]['usuario_imagen'];
            alumnoModel.alumnoNacimiento = alumns[x]['persona_nacimiento'];
            alumnoModel.alumnoTelefono = alumns[x]['persona_telefono'];
            alumnoModel.alumnoEmail = alumns[x]['usuario_email'];
            alumnoModel.alumnoEstado = alumns[x]['aula_alumno_estado'];

            await alumnoDatabase.insertarAlumno(alumnoModel);
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
