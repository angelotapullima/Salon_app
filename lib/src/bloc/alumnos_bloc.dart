import 'package:rxdart/subjects.dart';
import 'package:salon_app/src/database/alumnos_database.dart';
import 'package:salon_app/src/models/alumno_model.dart';

class AlumnosBloc {
  final alumnosDatabase = AlumnoDatabase();

  final _alumnoController = BehaviorSubject<List<AlumnoModel>>();

  Stream<List<AlumnoModel>> get aulaStream => _alumnoController.stream;

  dispose() {
    _alumnoController.close();
  }

  void getAlumno(String idAula) async {
    _alumnoController.sink.add(await alumnosDatabase.getAlumnos(idAula));
  }
}
