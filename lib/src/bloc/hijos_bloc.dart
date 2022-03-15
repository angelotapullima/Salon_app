import 'package:rxdart/subjects.dart';
import 'package:salon_app/src/database/hijo_database.dart';
import 'package:salon_app/src/models/alumno_model.dart';
import 'package:salon_app/src/preferencias/preferencias_usuario.dart';

class HijosBloc {
  final hijoDatabase = HijoDatabase();
  final prefs = Preferences();

  final _hijosController = BehaviorSubject<List<AlumnoModel>>();
  final _validarHijosController = BehaviorSubject<bool>();

  Stream<List<AlumnoModel>> get hijosStream => _hijosController.stream;
  Stream<bool> get validarHijosStream => _validarHijosController.stream;

  dispose() {
    _hijosController.close();
    _validarHijosController.close();
  }

  void getHijos() async {
    final algo = await hijoDatabase.getHijos();
    _hijosController.sink.add(algo);
  }

  void validarHijos() async {
    if (prefs.hijoId == null) {
      final hijitos = await hijoDatabase.getHijos();

      if (hijitos.isNotEmpty) {
        prefs.hijoIds = hijitos[0].idAlumno.toString();
        prefs.hijoNombres = '${hijitos[0].alumnoNombre} ${hijitos[0].alumnoApellido}';
      }
    }
    _validarHijosController.sink.add(true);
  }
}
