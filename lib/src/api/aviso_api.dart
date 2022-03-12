import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:salon_app/src/database/avisos_database.dart';
import 'package:salon_app/src/models/aviso_model.dart';
import 'package:salon_app/src/preferencias/preferencias_usuario.dart';
import 'package:salon_app/src/utils/constants.dart';
import 'package:http/http.dart' as http;

class AvisoApi {
  final avisosDatabase = AvisosDatabase();
  final prefs = Preferences();
  Future<void> getAvisos() async {
    try {
      final url = Uri.parse('$apiBaseURL/api/aviso/listar_avisos');

      final resp = await http.post(url, body: {
        'tn': prefs.token,
        'app': 'true',
      });

      final decodedData = json.decode(resp.body);

      for (var i = 0; i < decodedData['result']['avisos'].length; i++) {
        AvisoModel avisoModel = AvisoModel();

        var fecha = '';
        var hora = '';

        if (decodedData['result']['avisos'][i]['id_tipo_aviso'].toString() == '3') {
          final fechaFormat = decodedData['result']['avisos'][i]['aviso_fecha_creacion'].split(" ");
          fecha = fechaFormat[0];
          hora = fechaFormat[1];
        } else {
          final fechaFormat = decodedData['result']['avisos'][i]['aviso_fecha_pactada'].split(" ");
          fecha = fechaFormat[0];
          hora = fechaFormat[1];
        }

        avisoModel.idAviso = decodedData['result']['avisos'][i]['id_aviso'].toString();
        avisoModel.idAula = decodedData['result']['avisos'][i]['id_aula'].toString();
        avisoModel.idAlumno = decodedData['result']['avisos'][i]['id_alumno'].toString();
        avisoModel.idResponsable = decodedData['result']['avisos'][i]['id_responsable'].toString();
        avisoModel.idTipoAviso = decodedData['result']['avisos'][i]['id_tipo_aviso'].toString();
        avisoModel.avisoMensaje = decodedData['result']['avisos'][i]['aviso_mensaje'].toString();
        avisoModel.avisoFechaPactada = fecha;
        avisoModel.avisoHoraPactada = hora;
        avisoModel.avisoFechaCreacion = decodedData['result']['avisos'][i]['aviso_fecha_creacion'].toString();
        avisoModel.aulaGrado = decodedData['result']['avisos'][i]['aula_grado'].toString();
        avisoModel.aulaSeccion = decodedData['result']['avisos'][i]['aula_seccion'].toString();
        avisoModel.aulaNivel = decodedData['result']['avisos'][i]['aula_nivel'].toString();
        avisoModel.aulaEstado = decodedData['result']['avisos'][i]['aula_estado'].toString();
        avisoModel.tipoAvisoNombre = decodedData['result']['avisos'][i]['tipo_aviso_nombre'].toString();
        avisoModel.personaNombre = decodedData['result']['avisos'][i]['persona_nombre'].toString();
        avisoModel.personApellidoPaterno = decodedData['result']['avisos'][i]['persona_apellido_paterno'].toString();
        avisoModel.personaApellidoMaterno = decodedData['result']['avisos'][i]['persona_apellido_materno'].toString();
        await avisosDatabase.insertarAviso(avisoModel);
        //await aulaDatabase.insertarAula(aulaModel);

      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
