import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salon_app/src/bloc/provider_bloc.dart';
import 'package:salon_app/src/models/salon_tutor_model.dart';

import 'details_salon.dart';

class Aulas extends StatelessWidget {
  final String valor;
  const Aulas({Key? key, required this.valor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final aulaBloc = ProviderBloc.aula(context);
    aulaBloc.getAulas();

    return StreamBuilder(
        stream: aulaBloc.aulaStream,
        builder: (context, AsyncSnapshot<List<AulaModel>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isNotEmpty) {
              var listAulas = snapshot.data;
              return GridView.builder(
                padding: EdgeInsets.only(
                  top: ScreenUtil().setHeight(20),
                  left: ScreenUtil().setWidth(20),
                  right: ScreenUtil().setWidth(15),
                ),
                shrinkWrap: true,
                itemCount: listAulas!.length,
                physics: const ClampingScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 1,
                  crossAxisCount: 3,
                  mainAxisSpacing: ScreenUtil().setHeight(10),
                  crossAxisSpacing: ScreenUtil().setWidth(5),
                ),
                itemBuilder: (context, index3) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) {
                            return DetailSalonTutor(salon: listAulas[index3], valor: valor);
                          },
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            var begin = const Offset(0.0, 1.0);
                            var end = Offset.zero;
                            var curve = Curves.ease;

                            var tween = Tween(begin: begin, end: end).chain(
                              CurveTween(curve: curve),
                            );

                            return SlideTransition(
                              position: animation.drive(tween),
                              child: child,
                            );
                          },
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.teal.withOpacity(.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          '${listAulas[index3].aulaGrado}to ${listAulas[index3].aulaSeccion}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: Text('No existen salones'),
              );
            }
          } else {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }
        });
  }
}
