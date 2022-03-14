import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:salon_app/src/preferencias/preferencias_usuario.dart';
import 'package:salon_app/src/utils/constants.dart';

class LoginApi {
  final prefs = Preferences();
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
