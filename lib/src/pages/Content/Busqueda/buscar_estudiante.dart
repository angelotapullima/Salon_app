import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:salon_app/src/bloc/provider_bloc.dart';
import 'package:salon_app/src/models/salon_tutor_model.dart';
import 'package:salon_app/src/pages/Content/Citaciones/registro_citaciones.dart';
import 'package:salon_app/src/pages/Content/Incidencias/registro_de_incidencia.dart';
import 'package:salon_app/src/pages/Content/actividades/registro_actividades.dart';
import 'package:salon_app/src/utils/responsive.dart';
import 'package:salon_app/src/utils/utils.dart';

class BuscarEstudiantePage extends StatefulWidget {
  const BuscarEstudiantePage({Key? key, required this.valor}) : super(key: key);
  final String valor;

  @override
  _BuscarEstudiantePageState createState() => _BuscarEstudiantePageState();
}

class _BuscarEstudiantePageState extends State<BuscarEstudiantePage> with TickerProviderStateMixin {
  final TextEditingController _controllerBusqueda = TextEditingController();
  final _currentPageNotifier = ValueNotifier<bool>(false);

  final FocusNode _focusSearch = FocusNode();

  @override
  void dispose() {
    _controllerBusqueda.dispose();
    super.dispose();
  }

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      final busquedaBloc = ProviderBloc.busqueda(context);
      busquedaBloc.resetear();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    final busquedaBloc = ProviderBloc.busqueda(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF0EFEF),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        toolbarHeight: responsive.hp(8),
        centerTitle: false,
        backgroundColor: const Color(0xFFF0EFEF),
        flexibleSpace: SafeArea(
          child: KeyboardActions(
            config: KeyboardActionsConfig(keyboardSeparatorColor: Colors.white, keyboardBarColor: Colors.white, actions: [
              KeyboardActionsItem(
                focusNode: _focusSearch,
                toolbarButtons: [
                  (node) {
                    return closeNodeUtil(node);
                  }
                ],
              ),
            ]),
            child: Container(
              margin: EdgeInsets.only(
                left: responsive.wp(10),
                bottom: responsive.hp(1),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                        toolbarOptions: const ToolbarOptions(paste: true, cut: true, copy: true, selectAll: true),
                        controller: _controllerBusqueda,
                        keyboardType: TextInputType.text,
                        textAlign: TextAlign.start,
                        focusNode: _focusSearch,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelStyle: const TextStyle(color: Colors.white),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          hintText: 'Buscar estudiante',
                          hintStyle: const TextStyle(color: Colors.black45),
                        ),
                        onChanged: (value) {
                          if (value.isNotEmpty && value != ' ' && value != '') {
                            busquedaBloc.buscarEstudiante(value);

                            _currentPageNotifier.value = true;
                          } else {
                            busquedaBloc.resetear();
                          }
                        },
                        onSubmitted: (value) {
                          if (value.isNotEmpty && value != ' ' && value != '') {
                            _currentPageNotifier.value = true;

                            busquedaBloc.buscarEstudiante(value);

                            _currentPageNotifier.value = true;
                          } else {
                            busquedaBloc.resetear();
                          }
                        }),
                  ),
                  SizedBox(
                    width: responsive.wp(1),
                  ),
                  ValueListenableBuilder(
                    valueListenable: _currentPageNotifier,
                    builder: (BuildContext context, bool data, Widget? child) {
                      return (data)
                          ? InkWell(
                              onTap: () {
                                _controllerBusqueda.text = '';
                                busquedaBloc.resetear();
                                _currentPageNotifier.value = false;
                              },
                              child: CircleAvatar(
                                backgroundColor: Colors.grey,
                                radius: responsive.ip(1.5),
                                child: Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: responsive.ip(2),
                                ),
                              ),
                            )
                          : Container();
                    },
                  ),
                  SizedBox(
                    width: responsive.wp(1),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        margin: EdgeInsets.only(top: ScreenUtil().setHeight(15)),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
          color: Colors.white,
        ),
        child: Column(
          children: [
            SizedBox(
              height: responsive.hp(1),
            ),
            Expanded(
              child: AlumnosWidget(
                responsive: responsive,
                valor: widget.valor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AlumnosWidget extends StatelessWidget {
  const AlumnosWidget({
    Key? key,
    required this.responsive,
    required this.valor,
  }) : super(key: key);

  final Responsive responsive;
  final String valor;

  @override
  Widget build(BuildContext context) {
    final busquedaBloc = ProviderBloc.busqueda(context);
    return StreamBuilder(
      stream: busquedaBloc.busquedaStream,
      builder: (BuildContext context, AsyncSnapshot<List<AulaModel>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.isNotEmpty) {
            return ListView.builder(
              padding: EdgeInsets.only(top: responsive.hp(1)),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, i) {
                return SizedBox(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(12)),
                    child: Column(
                      children: [
                        Text(
                          "${snapshot.data![i].aulaGrado}to ${snapshot.data![i].aulaSeccion}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: (snapshot.data![i].alumnos!.length + 1) * ScreenUtil().setHeight(35),
                          child: ListView.builder(
                              itemCount: snapshot.data![i].alumnos!.length,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (_, indexito) {
                                var estudiante = snapshot.data![i].alumnos![indexito];
                                return (valor == '1')
                                    ? InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                              opaque: false,
                                              transitionDuration: const Duration(milliseconds: 400),
                                              pageBuilder: (context, animation, secondaryAnimation) {
                                                return RegistroDeIncidencia(
                                                  idAlumno: '${estudiante.idAlumno}',
                                                  idAula: '${snapshot.data![i].idAula}',
                                                  alumno: '${estudiante.alumnoNombre} ${estudiante.alumnoApellido}',
                                                  grado: '${snapshot.data![i].aulaGrado}to',
                                                  seccion: '${snapshot.data![i].aulaSeccion}',
                                                );
                                              },
                                              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                                return FadeTransition(
                                                  opacity: animation,
                                                  child: child,
                                                );
                                              },
                                            ),
                                          );
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            vertical: ScreenUtil().setHeight(5),
                                            horizontal: ScreenUtil().setHeight(5),
                                          ),
                                          margin: EdgeInsets.symmetric(
                                            vertical: ScreenUtil().setHeight(5),
                                          ),
                                          decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(5)),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Text('${int.parse(indexito.toString()) + 1}. '),
                                                  Text(' ${estudiante.alumnoNombre} ${estudiante.alumnoApellido}'),
                                                ],
                                              ),
                                              Row(
                                                // ignore: prefer_const_literals_to_create_immutables
                                                children: [
                                                  const Text('Dni: '),
                                                  const Text(
                                                    ' 44556677',
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    : FocusedMenuHolder(
                                        blurBackgroundColor: Colors.white.withOpacity(0.01),
                                        blurSize: 0,
                                        openWithTap: true,
                                        onPressed: () {},
                                        menuItems: [
                                          FocusedMenuItem(
                                              title: Row(
                                                children: [
                                                  Text(
                                                    'Registrar  Actividades',
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.w300,
                                                      fontSize: ScreenUtil().setSp(14),
                                                      letterSpacing: ScreenUtil().setSp(0.016),
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              trailingIcon: Icon(
                                                Fontisto.paper_plane,
                                                color: Colors.black,
                                                size: ScreenUtil().setHeight(20),
                                              ),
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  PageRouteBuilder(
                                                    opaque: false,
                                                    transitionDuration: const Duration(milliseconds: 400),
                                                    pageBuilder: (context, animation, secondaryAnimation) {
                                                      return RegistroActividades(
                                                        aula: false,
                                                        idAlumno: '${estudiante.idAlumno}',
                                                        idAula: '${snapshot.data![i].idAula}',
                                                        alumno: '${estudiante.alumnoNombre} ${estudiante.alumnoApellido}',
                                                        grado: '${snapshot.data![i].aulaGrado}to',
                                                        seccion: '${snapshot.data![i].aulaSeccion}',
                                                      );
                                                    },
                                                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                                      return FadeTransition(
                                                        opacity: animation,
                                                        child: child,
                                                      );
                                                    },
                                                  ),
                                                );
                                                //_addFaseEliminatoria(context, _catController.idCategoria);
                                              }),
                                          FocusedMenuItem(
                                              title: Row(
                                                children: [
                                                  Text(
                                                    'Registrar Citaciones',
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.w300,
                                                      fontSize: ScreenUtil().setSp(14),
                                                      letterSpacing: ScreenUtil().setSp(0.016),
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              trailingIcon: Icon(
                                                AntDesign.paperclip,
                                                color: Colors.black,
                                                size: ScreenUtil().setHeight(20),
                                              ),
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  PageRouteBuilder(
                                                    opaque: false,
                                                    transitionDuration: const Duration(milliseconds: 400),
                                                    pageBuilder: (context, animation, secondaryAnimation) {
                                                      return RegistroCitaciones(
                                                        aula: false,
                                                        idAlumno: '${estudiante.idAlumno}',
                                                        idAula: '${snapshot.data![i].idAula}',
                                                        alumno: '${estudiante.alumnoNombre} ${estudiante.alumnoApellido}',
                                                        grado: '${snapshot.data![i].aulaGrado}to',
                                                        seccion: '${snapshot.data![i].aulaSeccion}',
                                                      );
                                                    },
                                                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                                      return FadeTransition(
                                                        opacity: animation,
                                                        child: child,
                                                      );
                                                    },
                                                  ),
                                                );

                                                //_addFaseTodosVSTodos(context, _catController.idCategoria);
                                              }),
                                        ],
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            vertical: ScreenUtil().setHeight(10),
                                            horizontal: ScreenUtil().setHeight(5),
                                          ),
                                          margin: EdgeInsets.symmetric(
                                            vertical: ScreenUtil().setHeight(5),
                                          ),
                                          decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(5)),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Text('${int.parse(indexito.toString()) + 1}. '),
                                                  Text(' ${estudiante.alumnoNombre} ${estudiante.alumnoApellido}'),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                              }),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Column(
              children: [
                CircleAvatar(
                  radius: responsive.ip(5),
                  backgroundColor: Colors.grey,
                  child: Icon(
                    Icons.search,
                    color: Colors.yellow,
                    size: responsive.ip(4),
                  ),
                ),
                Center(
                  child: Text(
                    'Sin resultados',
                    style: TextStyle(
                      fontSize: responsive.ip(2),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(height: responsive.hp(5)),
              ],
            );
          }
        } else {
          return Container();
        }
      },
    );
  }
}
