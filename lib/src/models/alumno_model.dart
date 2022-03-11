class AlumnoModel {
  AlumnoModel({
    this.idAlumno,
    this.idAula,
    this.alumnoNombre,
    this.alumnoApellido,
    this.alumnoImagen,
    this.alumnoNacimiento,
    this.alumnoTelefono,
    this.alumnoEmail,
    this.alumnoEstado,
  });
  String? idAlumno;
  String? idAula;
  String? alumnoNombre;
  String? alumnoApellido;
  String? alumnoImagen;
  String? alumnoNacimiento;
  String? alumnoTelefono;
  String? alumnoEmail;
  String? alumnoEstado;

  static List<AlumnoModel> fromJsonList(List<dynamic> json) => json.map((i) => AlumnoModel.fromJson(i)).toList();

  Map<String, dynamic> toJson() => {
        'idAlumno': idAlumno,
        'idAula': idAula,
        'alumnoNombre': alumnoNombre,
        'alumnoApellido': alumnoApellido,
        'alumnoImagen': alumnoImagen,
        'alumnoNacimiento': alumnoNacimiento,
        'alumnoTelefono': alumnoTelefono,
        'alumnoEmail': alumnoEmail,
        'alumnoEstado': alumnoEstado,
      };

  factory AlumnoModel.fromJson(Map<String, dynamic> json) => AlumnoModel(
        idAlumno: json["idAlumno"],
        idAula: json["idAula"],
        alumnoNombre: json["alumnoNombre"],
        alumnoApellido: json["alumnoApellido"],
        alumnoImagen: json["alumnoImagen"],
        alumnoNacimiento: json["alumnoNacimiento"],
        alumnoTelefono: json["alumnoTelefono"],
        alumnoEmail: json["alumnoEmail"],
        alumnoEstado: json["alumnoEstado"],
      );
}
