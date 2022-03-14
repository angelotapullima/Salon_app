import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await getDatabase();

  Future<Database> getDatabase() async {
    final String path = join(await getDatabasesPath(), 'salonv1.db');
    return openDatabase(path, onCreate: (db, version) {
      db.execute(tableAulaSql);
      db.execute(tableAlumnosSql);
      db.execute(tableAvisosSql);
    }, version: 1, onDowngrade: onDatabaseDowngradeDelete);
  }

  static const String tableAulaSql = 'CREATE TABLE Aula('
      ' idAula TEXT PRIMARY KEY,'
      ' aulaGrado TEXT,'
      ' aulaSeccion TEXT,'
      ' aulaNivel TEXT,'
      ' aulaEstado TEXT)';

  static const String tableAlumnosSql = 'CREATE TABLE Alumno('
      ' idAlumno TEXT PRIMARY KEY,'
      ' idAula TEXT,'
      ' alumnoNombre TEXT,'
      ' alumnoApellido TEXT,'
      ' alumnoImagen TEXT,'
      ' alumnoNacimiento TEXT,'
      ' alumnoTelefono TEXT,'
      ' alumnoEmail TEXT,'
      ' alumnoEstado TEXT)';

  static const String tableAvisosSql = 'CREATE TABLE Aviso('
      ' idAviso TEXT PRIMARY KEY,'
      ' idAula TEXT,'
      ' idAlumno TEXT,'
      ' idResponsable TEXT,'
      ' idTipoAviso TEXT,'
      ' avisoMensaje TEXT,'
      ' avisoFechaPactada TEXT,'
      ' avisoHoraPactada TEXT,'
      ' avisoFechaCreacion TEXT,'
      ' aulaGrado TEXT,'
      ' aulaSeccion TEXT,'
      ' aulaNivel TEXT,'
      ' aulaEstado TEXT,'
      ' tipoAvisoNombre TEXT,'
      ' avisoTitulo TEXT,'
      ' personaNombre TEXT,'
      ' personApellidoPaterno TEXT,'
      ' personaApellidoMaterno TEXT)';
}
