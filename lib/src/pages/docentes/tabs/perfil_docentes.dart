import 'package:flutter/material.dart';
import 'package:salon_app/src/database/alumnos_database.dart';
import 'package:salon_app/src/database/aula_database.dart';
import 'package:salon_app/src/database/avisos_database.dart';
import 'package:salon_app/src/preferencias/preferencias_usuario.dart';

class PerfilDocentes extends StatelessWidget {
  const PerfilDocentes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Center(
        child: MaterialButton(
          color: Colors.red,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          onPressed: () async {
            final prefs = Preferences();
            prefs.clearPreferences();

            final alumnoDatabase = AlumnoDatabase();
            final aulaDatabase = AulaDatabase();
            final avisosDatabase = AvisosDatabase();

            await alumnoDatabase.deleteAlumnos();
            await aulaDatabase.deleteAula();
            await avisosDatabase.deleteAviso();

            Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false);
          },
          child: const Text(
            'Cerrar Sesión',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
