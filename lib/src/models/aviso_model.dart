class AvisoModel {
  String? idAviso;
  String? idAula;
  String? idAlumno;
  String? idResponsable;
  String? idTipoAviso;
  String? avisoMensaje;
  String? avisoFechaPactada;
  String? avisoHoraPactada;
  String? avisoFechaCreacion;
  String? aulaGrado;
  String? aulaSeccion;
  String? aulaNivel;
  String? aulaEstado;
  String? tipoAvisoNombre;
  String? personaNombre;
  String? personApellidoPaterno;
  String? personaApellidoMaterno;

  AvisoModel({
    this.idAviso,
    this.idAula,
    this.idAlumno,
    this.idResponsable,
    this.idTipoAviso,
    this.avisoMensaje,
    this.avisoFechaPactada,
    this.avisoHoraPactada,
    this.avisoFechaCreacion,
    this.aulaGrado,
    this.aulaSeccion,
    this.aulaNivel,
    this.aulaEstado,
    this.tipoAvisoNombre,
    this.personaNombre,
    this.personApellidoPaterno,
    this.personaApellidoMaterno,
  });

  static List<AvisoModel> fromJsonList(List<dynamic> json) => json.map((i) => AvisoModel.fromJson(i)).toList();

  Map<String, dynamic> toJson() => {
        'idAviso': idAviso,
        'idAula': idAula,
        'idAlumno': idAlumno,
        'idResponsable': idResponsable,
        'idTipoAviso': idTipoAviso,
        'avisoMensaje': avisoMensaje,
        'avisoFechaPactada': avisoFechaPactada,
        'avisoHoraPactada': avisoHoraPactada,
        'avisoFechaCreacion': avisoFechaCreacion,
        'aulaGrado': aulaGrado,
        'aulaSeccion': aulaSeccion,
        'aulaNivel': aulaNivel,
        'aulaEstado': aulaEstado,
        'tipoAvisoNombre': tipoAvisoNombre,
        'personaNombre': personaNombre,
        'personApellidoPaterno': personApellidoPaterno,
        'personaApellidoMaterno': personaApellidoMaterno,
      };

  factory AvisoModel.fromJson(Map<String, dynamic> json) => AvisoModel(
        idAviso: json["idAviso"],
        idAula: json["idAula"],
        idAlumno: json["idAlumno"],
        idResponsable: json["idResponsable"],
        idTipoAviso: json["idTipoAviso"],
        avisoMensaje: json["avisoMensaje"],
        avisoFechaPactada: json["avisoFechaPactada"],
        avisoHoraPactada: json["avisoHoraPactada"],
        avisoFechaCreacion: json["avisoFechaCreacion"],
        aulaGrado: json["aulaGrado"],
        aulaSeccion: json["aulaSeccion"],
        aulaNivel: json["aulaNivel"],
        aulaEstado: json["aulaEstado"],
        tipoAvisoNombre: json["tipoAvisoNombre"],
        personaNombre: json["personaNombre"],
        personApellidoPaterno: json["personApellidoPaterno"],
        personaApellidoMaterno: json["personaApellidoMaterno"],
      );
}




class FechaAvisosModel {
  String? fecha;
  List<AvisoModel>? citaciones;

  FechaAvisosModel({
    this.fecha,
    this.citaciones,
  });
}
