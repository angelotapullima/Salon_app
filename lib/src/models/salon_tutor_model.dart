class SalonTutorModelHead {
  String? grado;
  List<SalonTutorModel>? lista;

  SalonTutorModelHead({this.grado, this.lista});
}

class SalonTutorModel {
  String? seccion;
  String? grado;

  SalonTutorModel({this.seccion, this.grado});
}

final List<SalonTutorModelHead> listAulas = [
  SalonTutorModelHead(
    grado: '4',
    lista: [
      SalonTutorModel(
        seccion: 'A',
        grado: '4',
      ),
      SalonTutorModel(
        seccion: 'B',
        grado: '4',
      ),
      SalonTutorModel(
        seccion: 'C',
        grado: '4',
      ),
    ],
  ),
  SalonTutorModelHead(
    grado: '5',
    lista: [
      SalonTutorModel(
        seccion: 'A',
        grado: '5',
      ),
      SalonTutorModel(
        seccion: 'B',
        grado: '5',
      ),
      SalonTutorModel(
        seccion: 'C',
        grado: '5',
      ),
    ],
  ),
  SalonTutorModelHead(
    grado: '6',
    lista: [
      SalonTutorModel(
        seccion: 'A',
        grado: '6',
      ),
      SalonTutorModel(
        seccion: 'B',
        grado: '6',
      ),
      SalonTutorModel(
        seccion: 'C',
        grado: '6',
      ),
    ],
  ),
];
