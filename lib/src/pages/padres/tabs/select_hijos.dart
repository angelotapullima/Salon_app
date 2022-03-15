import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salon_app/src/bloc/provider_bloc.dart';
import 'package:salon_app/src/models/alumno_model.dart';
import 'package:salon_app/src/preferencias/preferencias_usuario.dart';
import 'package:salon_app/src/utils/responsive.dart';

class SelectHijos extends StatelessWidget {
  const SelectHijos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    final hijoBloc = ProviderBloc.hijo(context);
    hijoBloc.getHijos();
    return Material(
      color: Colors.black.withOpacity(.5),
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: StreamBuilder(
            stream: hijoBloc.hijosStream,
            builder: (context, AsyncSnapshot<List<AlumnoModel>> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.isNotEmpty) {
                  return SizedBox(
                    height: double.infinity,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: responsive.hp(3),
                          left: 0,
                          right: 0,
                          child: Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: responsive.wp(2),
                            ),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(35),
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: ScreenUtil().setHeight(24),
                                ),
                                Center(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: responsive.wp(2),
                                    ),
                                    child: Text(
                                      'Hijos',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: ScreenUtil().setSp(18),
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                const Divider(),
                                ListView.builder(
                                    padding: EdgeInsets.only(
                                      left: ScreenUtil().setWidth(15),
                                      right: ScreenUtil().setWidth(15),
                                      bottom: ScreenUtil().setHeight(10),
                                    ),
                                    itemCount: snapshot.data!.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          final prefs = Preferences();
                                          prefs.hijoIds = '${snapshot.data![index].idAlumno}';
                                          prefs.hijoNombres = '${snapshot.data![index].alumnoNombre} ${snapshot.data![index].alumnoApellido}';
                                          final hijoBloc = ProviderBloc.hijo(context);
                                          hijoBloc.validarHijos();

                                          final citacionesBloc = ProviderBloc.citaciones(context);
                                          citacionesBloc.getCitaciones('1', true);
                                          citacionesBloc.getIncidencias('3', true);
                                          citacionesBloc.getActividades('2', true);
                                          Navigator.pop(context);
                                        },
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                left: ScreenUtil().setWidth(15),
                                                right: ScreenUtil().setWidth(15),
                                                bottom: ScreenUtil().setHeight(3),
                                              ),
                                              child: Text('${snapshot.data![index].alumnoNombre} ${snapshot.data![index].alumnoApellido} '),
                                            ),
                                            const Divider()
                                          ],
                                        ),
                                      );
                                    })
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return const Center(
                    child: CupertinoActivityIndicator(),
                  );
                }
              } else {
                return const Center(
                  child: CupertinoActivityIndicator(),
                );
              }
            }),
      ),
    );
  }
}
