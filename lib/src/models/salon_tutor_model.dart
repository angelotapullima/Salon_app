import 'package:salon_app/src/models/alumno_model.dart';

class AulaModel {
  AulaModel({
    this.idAula,
    this.aulaGrado,
    this.aulaSeccion,
    this.aulaNivel,
    this.aulaEstado,
    this.alumnos,
  });
  String? idAula;
  String? aulaGrado;
  String? aulaSeccion;
  String? aulaNivel;
  String? aulaEstado;
  List<AlumnoModel>? alumnos;

  static List<AulaModel> fromJsonList(List<dynamic> json) => json.map((i) => AulaModel.fromJson(i)).toList();

  Map<String, dynamic> toJson() => {
        'idAula': idAula,
        'aulaGrado': aulaGrado,
        'aulaSeccion': aulaSeccion,
        'aulaNivel': aulaNivel,
        'aulaEstado': aulaEstado,
      };

  factory AulaModel.fromJson(Map<String, dynamic> json) => AulaModel(
        idAula: json["idAula"],
        aulaGrado: json["aulaGrado"],
        aulaSeccion: json["aulaSeccion"],
        aulaNivel: json["aulaNivel"],
        aulaEstado: json["aulaEstado"],
      );
}
