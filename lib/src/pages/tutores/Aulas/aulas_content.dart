import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salon_app/src/models/salon_tutor_model.dart';
import 'package:salon_app/src/pages/tutores/Aulas/details_salon.dart';

class AulasTutores extends StatelessWidget {
  final String valor;
  const AulasTutores({Key? key,required this.valor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: listAulas.length,
        itemBuilder: (context, index1) {
          return ListView.builder(
              physics: const ClampingScrollPhysics(),
              padding: EdgeInsets.only(
                top: ScreenUtil().setHeight(20),
                left: ScreenUtil().setWidth(20),
                right: ScreenUtil().setWidth(15),
              ),
              itemCount: 2,
              shrinkWrap: true,
              itemBuilder: (context, index2) {
                if (index2 == 0) {
                  return Text('${listAulas[index1].grado}to');
                }
                return GridView.builder(
                  shrinkWrap: true,
                  itemCount: listAulas[index1].lista!.length,
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
                              return DetailSalonTutor(salon: listAulas[index1].lista![index3],valor:valor);
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
                            '${listAulas[index1].grado}to ${listAulas[index1].lista![index3].seccion}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              });
        });
  }
}
