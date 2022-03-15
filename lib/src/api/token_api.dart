import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:salon_app/src/preferencias/preferencias_usuario.dart';
import 'package:salon_app/src/utils/constants.dart';

class TokenApi {
  final prefs = Preferences();
  Future<bool> enviarToken(String token) async {
    try {
      final url = Uri.parse('$apiBaseURL/api/admin/actualizar_usuario_token');

      final resp = await http.post(
        url,
        body: {
          'usuario_token': token,
          'app': 'true',
          'tn': prefs.token,
        },
      );

      final decodedData = json.decode(resp.body);

      if (decodedData['result'] == 1) {
        return true;
      } else {
        return false;
      }
    } catch (error, stacktrace) {
      if (kDebugMode) {
        print("Exception occured: $error stackTrace: $stacktrace");
      }
      return false;
    }
  }
}
