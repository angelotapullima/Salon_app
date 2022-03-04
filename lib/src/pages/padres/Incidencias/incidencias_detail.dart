import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salon_app/src/models/incidencias_padres.dart';

class IncidenciasDetail extends StatefulWidget {
  final IncidenciasPadres incidencias;
  const IncidenciasDetail({Key? key, required this.incidencias}) : super(key: key);

  @override
  State<IncidenciasDetail> createState() => _IncidenciasDetailState();
}

class _IncidenciasDetailState extends State<IncidenciasDetail> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withOpacity(.5),
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Center(
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(12),
              ),
              width: double.infinity,
              height: ScreenUtil().setHeight(650),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(35)),
              child: Column(
                mainAxisAlignment:MainAxisAlignment.start ,
                children: [
                  SizedBox(
                    height: ScreenUtil().setHeight(24),
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(12),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              '${widget.incidencias.titulo}',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(18),
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(width: ScreenUtil().setWidth(10)),
                          Text(
                            '${widget.incidencias.fecha}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(16),
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(12),
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Reportado por: ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(18),
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          '${widget.incidencias.personaRegistro}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(18),
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                   SizedBox(
                    height: ScreenUtil().setHeight(24),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(12),
                    ),
                    child: Text(
                      '${widget.incidencias.detalle}',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(14),
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
