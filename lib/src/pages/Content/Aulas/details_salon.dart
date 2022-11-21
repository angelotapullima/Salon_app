import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:salon_app/src/bloc/provider_bloc.dart';
import 'package:salon_app/src/models/alumno_model.dart';
import 'package:salon_app/src/models/salon_tutor_model.dart';
import 'package:salon_app/src/pages/Content/Citaciones/registro_citaciones.dart';
import 'package:salon_app/src/pages/Content/Incidencias/registro_de_incidencia.dart';
import 'package:salon_app/src/pages/Content/actividades/registro_actividades.dart';

class DetailSalonTutor extends StatelessWidget {
  final String valor;
  final AulaModel salon;
  const DetailSalonTutor({Key? key, required this.salon, required this.valor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final alumnoBloc = ProviderBloc.alumno(context);
    alumnoBloc.getAlumno('${salon.idAula}');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          '${salon.aulaGrado}to ${salon.aulaSeccion}',
          style: const TextStyle(color: Colors.black),
        ),
        actions: [
          (valor == '2')
              ? FocusedMenuHolder(
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
                              transitionDuration:
                                  const Duration(milliseconds: 400),
                              pageBuilder:
                                  (context, animation, secondaryAnimation) {
                                return RegistroActividades(
                                  aula: true,
                                  idAlumno: '',
                                  idAula: '${salon.idAula}',
                                  alumno: '',
                                  grado: '${salon.aulaGrado}to',
                                  seccion: '${salon.aulaSeccion}',
                                );
                              },
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
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
                              transitionDuration:
                                  const Duration(milliseconds: 400),
                              pageBuilder:
                                  (context, animation, secondaryAnimation) {
                                return RegistroCitaciones(
                                  aula: true,
                                  idAlumno: '',
                                  idAula: '${salon.idAula}',
                                  alumno: '',
                                  grado: '${salon.aulaGrado}to',
                                  seccion: '${salon.aulaSeccion}',
                                );
                              },
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
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
                  child: const Icon(Icons.add),
                )
              : Container(),
          SizedBox(width: ScreenUtil().setWidth(10))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setWidth(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Lista de Alumnos',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(8),
            ),
            StreamBuilder(
                stream: alumnoBloc.aulaStream,
                builder: (context, AsyncSnapshot<List<AlumnoModel>> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.isNotEmpty) {
                      return Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.only(bottom: 20),
                          itemCount: snapshot.data!.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return (valor == '1')
                                ? /*InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          opaque: false,
                                          transitionDuration:
                                              const Duration(milliseconds: 400),
                                          pageBuilder: (context, animation,
                                              secondaryAnimation) {
                                            return RegistroDeIncidencia(
                                              idAlumno:
                                                  '${snapshot.data![index].idAlumno}',
                                              idAula: '${salon.idAula}',
                                              alumno:
                                                  '${snapshot.data![index].alumnoNombre} ${snapshot.data![index].alumnoApellido}',
                                              grado: '${salon.aulaGrado}to',
                                              seccion: '${salon.aulaSeccion}',
                                            );
                                          },
                                          transitionsBuilder: (context,
                                              animation,
                                              secondaryAnimation,
                                              child) {
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
                                        vertical: ScreenUtil().setHeight(8),
                                        horizontal: ScreenUtil().setHeight(5),
                                      ),
                                      margin: EdgeInsets.symmetric(
                                        vertical: ScreenUtil().setHeight(5),
                                      ),
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                  '${int.parse(index.toString()) + 1}. '),
                                              Text(
                                                  ' ${snapshot.data![index].alumnoNombre} ${snapshot.data![index].alumnoApellido}'),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                */FocusedMenuHolder(
                              blurBackgroundColor:
                              Colors.white.withOpacity(0.01),
                              blurSize: 0,
                              openWithTap: true,
                              onPressed: () {},
                              menuItems: [
                                FocusedMenuItem(
                                    title: Row(
                                      children: [
                                        Text(
                                          'Registrar  Incidencias',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize:
                                            ScreenUtil().setSp(14),
                                            letterSpacing:
                                            ScreenUtil().setSp(0.016),
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
                                          transitionDuration:
                                          const Duration(milliseconds: 400),
                                          pageBuilder: (context, animation,
                                              secondaryAnimation) {
                                            return RegistroDeIncidencia(
                                              idAlumno:
                                              '${snapshot.data![index].idAlumno}',
                                              idAula: '${salon.idAula}',
                                              alumno:
                                              '${snapshot.data![index].alumnoNombre} ${snapshot.data![index].alumnoApellido}',
                                              grado: '${salon.aulaGrado}to',
                                              seccion: '${salon.aulaSeccion}',
                                            );
                                          },
                                          transitionsBuilder: (context,
                                              animation,
                                              secondaryAnimation,
                                              child) {
                                            return FadeTransition(
                                              opacity: animation,
                                              child: child,
                                            );
                                          },
                                        ),
                                      );  }),
                                FocusedMenuItem(
                                    title: Row(
                                      children: [
                                        Text(
                                          'Registrar Citaciones',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize:
                                            ScreenUtil().setSp(14),
                                            letterSpacing:
                                            ScreenUtil().setSp(0.016),
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
                                          transitionDuration:
                                          const Duration(
                                              milliseconds: 400),
                                          pageBuilder: (context,
                                              animation,
                                              secondaryAnimation) {
                                            return RegistroCitaciones(
                                              aula: false,
                                              idAlumno:
                                              '${snapshot.data![index].idAlumno}',
                                              idAula: '${salon.idAula}',
                                              alumno:
                                              '${snapshot.data![index].alumnoNombre} ${snapshot.data![index].alumnoApellido}',
                                              grado:
                                              '${salon.aulaGrado}to',
                                              seccion:
                                              '${salon.aulaSeccion}',
                                            );
                                          },
                                          transitionsBuilder: (context,
                                              animation,
                                              secondaryAnimation,
                                              child) {
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
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius:
                                    BorderRadius.circular(5)),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                            '${int.parse(index.toString()) + 1}. '),
                                        Text(
                                            ' ${snapshot.data![index].alumnoNombre} ${snapshot.data![index].alumnoApellido}'),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ): FocusedMenuHolder(
                                    blurBackgroundColor:
                                        Colors.white.withOpacity(0.01),
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
                                                  fontSize:
                                                      ScreenUtil().setSp(14),
                                                  letterSpacing:
                                                      ScreenUtil().setSp(0.016),
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
                                                transitionDuration:
                                                    const Duration(
                                                        milliseconds: 400),
                                                pageBuilder: (context,
                                                    animation,
                                                    secondaryAnimation) {
                                                  return RegistroActividades(
                                                    aula: false,
                                                    idAlumno:
                                                        '${snapshot.data![index].idAlumno}',
                                                    idAula: '${salon.idAula}',
                                                    alumno:
                                                        '${snapshot.data![index].alumnoNombre} ${snapshot.data![index].alumnoApellido}',
                                                    grado:
                                                        '${salon.aulaGrado}to',
                                                    seccion:
                                                        '${salon.aulaSeccion}',
                                                  );
                                                },
                                                transitionsBuilder: (context,
                                                    animation,
                                                    secondaryAnimation,
                                                    child) {
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
                                                  fontSize:
                                                      ScreenUtil().setSp(14),
                                                  letterSpacing:
                                                      ScreenUtil().setSp(0.016),
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
                                                transitionDuration:
                                                    const Duration(
                                                        milliseconds: 400),
                                                pageBuilder: (context,
                                                    animation,
                                                    secondaryAnimation) {
                                                  return RegistroCitaciones(
                                                    aula: false,
                                                    idAlumno:
                                                        '${snapshot.data![index].idAlumno}',
                                                    idAula: '${salon.idAula}',
                                                    alumno:
                                                        '${snapshot.data![index].alumnoNombre} ${snapshot.data![index].alumnoApellido}',
                                                    grado:
                                                        '${salon.aulaGrado}to',
                                                    seccion:
                                                        '${salon.aulaSeccion}',
                                                  );
                                                },
                                                transitionsBuilder: (context,
                                                    animation,
                                                    secondaryAnimation,
                                                    child) {
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
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                  '${int.parse(index.toString()) + 1}. '),
                                              Text(
                                                  ' ${snapshot.data![index].alumnoNombre} ${snapshot.data![index].alumnoApellido}'),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                          },
                        ),
                      );
                    } else {
                      return const Center(
                        child: Text('No existen Alumnos'),
                      );
                    }
                  } else {
                    return const Center(
                      child: CupertinoActivityIndicator(),
                    );
                  }
                })
          ],
        ),
      ),
    );
  }
}
