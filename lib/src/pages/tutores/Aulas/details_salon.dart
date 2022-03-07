import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:salon_app/src/models/salon_tutor_model.dart';
import 'package:salon_app/src/pages/padres/Citaciones/registro_citaciones.dart';
import 'package:salon_app/src/pages/padres/Incidencias/registro_de_incidencia.dart';
import 'package:salon_app/src/pages/padres/actividades/registro_actividades.dart';

class DetailSalonTutor extends StatelessWidget {
  final String valor;
  final SalonTutorModel salon;
  const DetailSalonTutor({Key? key, required this.salon, required this.valor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          '${salon.grado}to ${salon.seccion}',
          style: const TextStyle(color: Colors.black),
        ),
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
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 20),
                itemCount: 13,
                shrinkWrap: true,
                itemBuilder: (context, index) {
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
                                    alumno: 'Alumno de prueba',
                                    grado: '${salon.grado}to',
                                    seccion: '${salon.seccion}',
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
                                    Text('${int.parse(index.toString()) + 1}. '),
                                    const Text(' Alumno de prueba'),
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
                                          alumno: 'Alumno de prueba',
                                          grado: '${salon.grado}to',
                                          seccion: '${salon.seccion}',
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
                                          alumno: 'Alumno de prueba',
                                          grado: '${salon.grado}to',
                                          seccion: '${salon.seccion}',
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
                                    Text('${int.parse(index.toString()) + 1}. '),
                                    const Text(' Alumno de prueba'),
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
                        );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}


/*
                        
                         */