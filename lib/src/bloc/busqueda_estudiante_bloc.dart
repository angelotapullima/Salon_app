import 'package:rxdart/rxdart.dart';
import 'package:salon_app/src/api/aula_api.dart';
import 'package:salon_app/src/database/alumnos_database.dart';
import 'package:salon_app/src/database/aula_database.dart';
import 'package:salon_app/src/models/alumno_model.dart';
import 'package:salon_app/src/models/salon_tutor_model.dart';

class BusquedaEstudianteBloc {
  final aulaDatabase = AulaDatabase();
  final alumnosDatabase = AlumnoDatabase();
  final aulaApi = AulaApi();
  final _busquedaController = BehaviorSubject<List<AulaModel>>();

  Stream<List<AulaModel>> get busquedaStream => _busquedaController.stream;

  dispose() {
    _busquedaController.close();
  }

  void buscarEstudiante(String query) async {
    _busquedaController.sink.add(await obtenerEstudiantes(query));
  }

  void resetear() async {
    _busquedaController.sink.add([]);
  }

  Future<List<AulaModel>> obtenerEstudiantes(String query) async {
    final List<AulaModel> result = [];

    final aulas = await aulaDatabase.getAulas();

    for (var i = 0; i < aulas.length; i++) {
      AulaModel aula = AulaModel();
      aula.idAula = aulas[i].idAula;
      aula.aulaGrado = aulas[i].aulaGrado;
      aula.aulaSeccion = aulas[i].aulaSeccion;
      aula.aulaNivel = aulas[i].aulaNivel;
      aula.aulaEstado = aulas[i].aulaEstado;

      final List<AlumnoModel> alumnos = [];

      final listEstudiantes = await alumnosDatabase.getAlumnosByQuery(aula.idAula.toString(), query);

      for (var x = 0; x < listEstudiantes.length; x++) {
        alumnos.add(listEstudiantes[x]);
      }
      aula.alumnos = alumnos;

      if (alumnos.isNotEmpty) {
        result.add(aula);
      }
    }

    return result;
  }
}
