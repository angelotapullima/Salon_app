
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salon_app/src/models/incidencias_padres.dart';
import 'package:salon_app/src/pages/padres/incidencias/incidencias_detail.dart';

class IncideciasContent extends StatelessWidget {
  const IncideciasContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ListView.builder(
        padding: EdgeInsets.only(
          top: ScreenUtil().setHeight(15),
        ),
        itemCount: listIncidencias.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(
              vertical: ScreenUtil().setHeight(10),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: ScreenUtil().setWidth(100),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(5),
                      vertical: ScreenUtil().setWidth(5),
                    ),
                    child: Text(
                      '${listIncidencias[index].fecha}',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: ScreenUtil().setSp(16),
                        color: const Color(0xff323a54),
                        fontWeight: FontWeight.w600,
                        letterSpacing: ScreenUtil().setSp(0.016),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: listIncidencias[index].lista!.length,
                      itemBuilder: (context, index2) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                opaque: false,
                                transitionDuration: const Duration(milliseconds: 400),
                                pageBuilder: (context, animation, secondaryAnimation) {
                                  return IncidenciasDetail(
                                    incidencias: listIncidencias[index].lista![index2],
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
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 2,
                                  offset: const Offset(2, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: ScreenUtil().setHeight(2),
                              horizontal: ScreenUtil().setWidth(4),
                            ),
                            margin: EdgeInsets.symmetric(
                              vertical: ScreenUtil().setHeight(8),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${listIncidencias[index].lista![index2].titulo}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Reportado por: ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: ScreenUtil().setSp(12),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        '  ${listIncidencias[index].lista![index2].personaRegistro} ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: ScreenUtil().setSp(13.5),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  '${listIncidencias[index].lista![index2].detalle}',
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: ScreenUtil().setSp(13),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
