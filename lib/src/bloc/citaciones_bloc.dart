import 'package:rxdart/rxdart.dart';
import 'package:salon_app/src/api/aviso_api.dart';
import 'package:salon_app/src/api/local_notification_api.dart';
import 'package:salon_app/src/database/avisos_database.dart';
import 'package:salon_app/src/models/aviso_model.dart';
import 'package:salon_app/src/utils/utils.dart';

class CitacionesBloc {
  final avisosDatabase = AvisosDatabase();
  final avisoApi = AvisoApi();
  final _citacionesControllerController = BehaviorSubject<List<CitacionesMoldel>>();

  Stream<List<CitacionesMoldel>> get citacionesStream => _citacionesControllerController.stream;

  dispose() {
    _citacionesControllerController.close();
  }

  void getCitaciones() async {
    _citacionesControllerController.sink.add(await getCitacionesDate());
    await avisoApi.getAvisos();
    _citacionesControllerController.sink.add(await getCitacionesDate());
  }

  Future<List<CitacionesMoldel>> getCitacionesDate() async {
    final List<CitacionesMoldel> listaReturn = [];
    final List<String> listDates = [];

    var now = DateTime.now();
    String fecha = "${now.year.toString().padLeft(2, '0')}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";

    final fechasAlertas = await avisosDatabase.getCitaciones(fecha);

    if (fechasAlertas.isNotEmpty) {
      for (var i = 0; i < fechasAlertas.length; i++) {
        listDates.add(fechasAlertas[i].avisoFechaPactada.toString());
      }
    }

    if (listDates.isNotEmpty) {
      for (var x = 0; x < listDates.length; x++) {
        final List<AvisoModel> alertSubList = [];
        //final List<String> horitas = [];
        CitacionesMoldel fechaAlertModel = CitacionesMoldel();
        fechaAlertModel.fecha = obtenerFecha(listDates[x].toString());

        final fechix = await avisosDatabase.getAvisoByFecha(listDates[x].toString(), '1');

        if (fechix.isNotEmpty) {
          for (var y = 0; y < fechix.length; y++) {
            //final clients = await clienteDatabase.getClientPorIdCliente(fechix[y].idClient.toString());

            DateTime fechita = DateTime.parse('${fechix[y].avisoFechaPactada} ${fechix[y].avisoHoraPactada}');

            if (fechita.isAfter(DateTime.now())) {
              Duration _horas = fechita.difference(DateTime.now());

              if (_horas.inHours < 1) {
                LocalNotificationApi.showAlertProgramado(
                  id: y,
                  title: '${fechix[y].tipoAvisoNombre}',
                  body: "${fechix[y].avisoMensaje} | Hoy a las ${fechix[y].avisoHoraPactada} horas",
                  playLoad: '${fechix[y].idAviso}',
                  time: DateTime.now().add(const Duration(seconds: 2)),
                );
              }
              LocalNotificationApi.showAlertProgramado(
                id: y,
                title: '${fechix[y].tipoAvisoNombre}',
                body: '${fechix[y].avisoMensaje} | Hoy a las ${fechix[y].avisoHoraPactada} horas',
                playLoad: '${fechix[y].idAviso}',
                time: DateTime.now().add(
                  Duration(hours: _horas.inHours, minutes: _horas.inMinutes),
                ),
              );
            }
            AvisoModel alertModel = AvisoModel();

            alertModel.idAviso = fechix[y].idAviso;
            alertModel.idAula = fechix[y].idAula;
            alertModel.idAlumno = fechix[y].idAlumno;
            alertModel.idResponsable = fechix[y].idResponsable;
            alertModel.idTipoAviso = fechix[y].idTipoAviso;
            alertModel.avisoMensaje = fechix[y].avisoMensaje;
            alertModel.avisoFechaPactada = fechix[y].avisoFechaPactada;
            alertModel.avisoHoraPactada = fechix[y].avisoHoraPactada;
            alertModel.avisoFechaCreacion = fechix[y].avisoFechaCreacion;
            alertModel.aulaGrado = fechix[y].aulaGrado;
            alertModel.aulaSeccion = fechix[y].aulaSeccion;
            alertModel.aulaNivel = fechix[y].aulaNivel;
            alertModel.aulaEstado = fechix[y].aulaEstado;
            alertModel.tipoAvisoNombre = fechix[y].tipoAvisoNombre;
            alertModel.personaNombre = fechix[y].personaNombre;
            alertModel.personApellidoPaterno = fechix[y].personApellidoPaterno;
            alertModel.personaApellidoMaterno = fechix[y].personaApellidoMaterno;

            alertSubList.add(alertModel);
          }
        }

        fechaAlertModel.citaciones = alertSubList;
        if (alertSubList.isNotEmpty) {
          listaReturn.add(fechaAlertModel);
        }
      }
    }

    return listaReturn;
  }
}
