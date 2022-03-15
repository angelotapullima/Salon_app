import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:salon_app/src/database/aula_database.dart';
import 'package:salon_app/src/database/hijo_database.dart';
import 'package:salon_app/src/models/alumno_model.dart';
import 'package:salon_app/src/models/salon_tutor_model.dart';
import 'package:salon_app/src/preferencias/preferencias_usuario.dart';
import 'package:salon_app/src/utils/constants.dart';

class LoginApi {
  final prefs = Preferences();
  final hijoDatabase = HijoDatabase();
  final aulaDatabase = AulaDatabase();
  //final prefsBufiPaymets = new PreferencesBufiPayments();

  Future<LoginModel> login(String user, String pass) async {
    try {
      final url = Uri.parse('$apiBaseURL/api/Login/validar_sesion');

      final resp = await http.post(url, body: {
        'usuario_nickname': user,
        'usuario_contrasenha': pass,
        'app': 'true',
      });

      final decodedData = json.decode(resp.body);

      final int code = decodedData['result']['code'];
      LoginModel loginModel = LoginModel();
      loginModel.code = code.toString();
      loginModel.message = decodedData['result']['message'];

      if (code == 1) {
        if (kDebugMode) {
          print('code suscessfull');
        }

        prefs.idUsers = decodedData['data']['c_u'];
        prefs.userNicknames = decodedData['data']['_n'];
        prefs.userEmails = decodedData['data']['u_e'];
        prefs.images = decodedData['data']['u_i'];
        prefs.personNames = decodedData['data']['p_n'];
        prefs.personSurnames = '${decodedData['data']['p_p']} ${decodedData['data']['p_m']}';
        prefs.idRols = decodedData['data']['ru'];
        prefs.rolNombres = decodedData['data']['rn'];
        prefs.tokens = decodedData['data']['tn'];

        if (decodedData['alumnos'].length > 0) {
          for (var i = 0; i < decodedData['alumnos'].length; i++) {
            AlumnoModel alumnoModel = AlumnoModel();

            alumnoModel.idAlumno = decodedData['alumnos'][i]['id_alumno'];
            alumnoModel.idAula = decodedData['alumnos'][i]['id_aula'];
            alumnoModel.alumnoNombre = decodedData['alumnos'][i]['persona_nombre'];
            alumnoModel.alumnoApellido =
                '${decodedData['alumnos'][i]['persona_apellido_paterno']} ${decodedData['alumnos'][i]['persona_apellido_materno']}';
            alumnoModel.alumnoImagen = decodedData['alumnos'][i]['usuario_imagen'];
            alumnoModel.alumnoNacimiento = decodedData['alumnos'][i]['persona_nacimiento'];
            alumnoModel.alumnoTelefono = decodedData['alumnos'][i]['persona_telefono'];
            alumnoModel.alumnoEmail = decodedData['alumnos'][i]['usuario_email'];
            alumnoModel.alumnoEstado = decodedData['alumnos'][i]['aula_alumno_estado'];

            await hijoDatabase.insertarHijo(alumnoModel);

            AulaModel aulaModel = AulaModel();

            aulaModel.idAula = decodedData['alumnos'][i]['id_aula'];
            aulaModel.aulaGrado = decodedData['alumnos'][i]['aula_grado'];
            aulaModel.aulaSeccion = decodedData['alumnos'][i]['aula_seccion'];
            aulaModel.aulaNivel = decodedData['alumnos'][i]['aula_nivel'];
            aulaModel.aulaEstado = decodedData['alumnos'][i]['aula_estado'];
            await aulaDatabase.insertarAula(aulaModel);
          }
        }

        return loginModel;
      } else {
        return loginModel;
      }
    } catch (error, stacktrace) {
      if (kDebugMode) {
        print("Exception occured: $error stackTrace: $stacktrace");
      }
      LoginModel loginModel = LoginModel();
      loginModel.code = '2';
      loginModel.message = 'Error en la petición';
      return loginModel;
    }
  }
}

class LoginModel {
  String? code;
  String? message;

  LoginModel({this.code, this.message});
}
