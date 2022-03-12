import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salon_app/src/bloc/provider_bloc.dart';
import 'package:salon_app/src/pages/docentes/home_docentes.dart';
import 'package:salon_app/src/pages/padres/home_padres.dart';
import 'package:salon_app/src/pages/tutores/home_tutores.dart';
import 'package:salon_app/src/preferencias/preferencias_usuario.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final prefs = Preferences();
    return Scaffold(
      body: (prefs.idRol == '4')
          ? const HomeDocentes()
          : (prefs.idRol == '5')
              ? const HomeTutores()
              : Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: ScreenUtil().setHeight(100),
                    horizontal: ScreenUtil().setWidth(20),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            final bottomBloc = ProviderBloc.botton(context);
                            bottomBloc.changePage(0);
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                transitionDuration: const Duration(milliseconds: 400),
                                pageBuilder: (context, animation, secondaryAnimation) {
                                  return const HomePadre();
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
                            decoration: const BoxDecoration(
                              color: Colors.blue,
                            ),
                            height: ScreenUtil().setHeight(150),
                            width: double.infinity,
                            child: Center(
                              child: Text(
                                'Padres',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: ScreenUtil().setSp(20),
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            final bottomBloc = ProviderBloc.botton(context);
                            bottomBloc.changePage(0);
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                transitionDuration: const Duration(milliseconds: 400),
                                pageBuilder: (context, animation, secondaryAnimation) {
                                  return const HomeTutores();
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
                            decoration: const BoxDecoration(
                              color: Colors.red,
                            ),
                            height: ScreenUtil().setHeight(150),
                            width: double.infinity,
                            child: Center(
                              child: Text(
                                'Tutores',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: ScreenUtil().setSp(20),
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            final bottomBloc = ProviderBloc.botton(context);
                            bottomBloc.changePage(0);
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                transitionDuration: const Duration(milliseconds: 400),
                                pageBuilder: (context, animation, secondaryAnimation) {
                                  return const HomeDocentes();
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
                            decoration: const BoxDecoration(
                              color: Colors.green,
                            ),
                            height: ScreenUtil().setHeight(150),
                            width: double.infinity,
                            child: Center(
                              child: Text(
                                'Docentes',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: ScreenUtil().setSp(20),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }
}
