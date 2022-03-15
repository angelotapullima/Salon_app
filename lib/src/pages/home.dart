import 'package:flutter/material.dart'; 
import 'package:salon_app/src/pages/docentes/home_docentes.dart';
import 'package:salon_app/src/pages/padres/home_padres.dart';
import 'package:salon_app/src/pages/tutores/home_tutores.dart';
import 'package:salon_app/src/preferencias/preferencias_usuario.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final prefs = Preferences();
    return Scaffold(
      body: (prefs.idRol == '4')
          ? const HomeDocentes()
          : (prefs.idRol == '5')
              ? const HomeTutores()
              : const HomePadre());
  }
}
