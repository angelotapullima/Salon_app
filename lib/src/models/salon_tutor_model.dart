class AulaModel {
  AulaModel({
    this.idAula,
    this.aulaGrado,
    this.aulaSeccion,
    this.aulaNivel,
    this.aulaEstado,
  });
  String? idAula;
  String? aulaGrado;
  String? aulaSeccion;
  String? aulaNivel;
  String? aulaEstado;
  
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

