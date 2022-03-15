import 'package:rxdart/rxdart.dart';
import 'package:salon_app/src/api/aviso_api.dart';
import 'package:salon_app/src/api/local_notification_api.dart';
import 'package:salon_app/src/database/avisos_database.dart';
import 'package:salon_app/src/models/aviso_model.dart';
import 'package:salon_app/src/preferencias/preferencias_usuario.dart';
import 'package:salon_app/src/utils/utils.dart';

class AvisosBloc {
  final avisosDatabase = AvisosDatabase();
  final avisoApi = AvisoApi();
  final prefs = Preferences();

  final _citacionesController = BehaviorSubject<List<FechaAvisosModel>>();
  Stream<List<FechaAvisosModel>> get citacionesStream => _citacionesController.stream;

  final _actividadesController = BehaviorSubject<List<FechaAvisosModel>>();
  Stream<List<FechaAvisosModel>> get actividadesStream => _actividadesController.stream;

  final _incidenciasController = BehaviorSubject<List<FechaAvisosModel>>();
  Stream<List<FechaAvisosModel>> get incidenciasStream => _incidenciasController.stream;

  dispose() {
    _citacionesController.close();
    _actividadesController.close();
    _incidenciasController.close();
  }

  void getIncidencias(String tipoAviso, bool esHijo) async {
    _incidenciasController.sink.add(await getAvisosDate(tipoAviso, esHijo));
    if (esHijo) {
      await avisoApi.getAvisosHijos();
    } else {
      await avisoApi.getAvisos();
    }
    await avisoApi.getAvisos();
    _incidenciasController.sink.add(await getAvisosDate(tipoAviso, esHijo));
  }

  void getActividades(String tipoAviso, bool esHijo) async {
    _actividadesController.sink.add(await getAvisosDate(tipoAviso, esHijo));
    if (esHijo) {
      await avisoApi.getAvisosHijos();
    } else {
      await avisoApi.getAvisos();
    }
    _actividadesController.sink.add(await getAvisosDate(tipoAviso, esHijo));
  }

  void getCitaciones(String tipoAviso, bool esHijo) async {
    _citacionesController.sink.add(await getAvisosDate(tipoAviso, esHijo));
    if (esHijo) {
      await avisoApi.getAvisosHijos();
    } else {
      await avisoApi.getAvisos();
    }
    _citacionesController.sink.add(await getAvisosDate(tipoAviso, esHijo));
  }

  Future<List<FechaAvisosModel>> getAvisosDate(String tipoAviso, bool esHijo) async {
    final List<FechaAvisosModel> listaReturn = [];
    final List<String> listDates = [];

    String fecha = '';
    var now = DateTime.now();

    if (tipoAviso == '3') {
      var nuevaNow = now.subtract(const Duration(days: 7));
      fecha = "${nuevaNow.year.toString().padLeft(2, '0')}-${nuevaNow.month.toString().padLeft(2, '0')}-${nuevaNow.day.toString().padLeft(2, '0')}";
    } else {
      fecha = "${now.year.toString().padLeft(2, '0')}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
    }
    var fechasAlertas = [];
    if (esHijo) {
      if (prefs.hijoId == null) {
        return [];
      }
      fechasAlertas = await avisosDatabase.getAvisosHijo(fecha, tipoAviso, prefs.hijoId);
    } else {
      fechasAlertas = await avisosDatabase.getAvisos(fecha, tipoAviso);
    }

    if (fechasAlertas.isNotEmpty) {
      for (var i = 0; i < fechasAlertas.length; i++) {
        listDates.add(fechasAlertas[i].avisoFechaPactada.toString());
      }
    }

    if (listDates.isNotEmpty) {
      for (var x = 0; x < listDates.length; x++) {
        final List<AvisoModel> alertSubList = [];
        //final List<String> horitas = [];
        FechaAvisosModel fechaAlertModel = FechaAvisosModel();
        fechaAlertModel.fecha = obtenerFecha(listDates[x].toString());
        var fechix = [];
        if (esHijo) { if (prefs.hijoId == null) {
        return [];
      }
          fechix = await avisosDatabase.getAvisoByFechaHijo(listDates[x].toString(), tipoAviso, prefs.hijoId);
        } else {
          fechix = await avisosDatabase.getAvisoByFecha(listDates[x].toString(), tipoAviso);
        }

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
            alertModel.idHijo = fechix[y].idHijo;
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
            alertModel.avisoTitulo = fechix[y].avisoTitulo;
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
