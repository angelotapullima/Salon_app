import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salon_app/src/models/aviso_model.dart';
import 'package:salon_app/src/utils/utils.dart';

class CitacionesDetail extends StatefulWidget {
  final AvisoModel aviso;
  const CitacionesDetail({Key? key, required this.aviso}) : super(key: key);

  @override
  State<CitacionesDetail> createState() => _CitacionesDetailState();
}

class _CitacionesDetailState extends State<CitacionesDetail> {
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
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                '${widget.aviso.aulaGrado} ${widget.aviso.aulaSeccion} - ${widget.aviso.aulaNivel}',
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
                              '${obtenerFecha('${widget.aviso.avisoFechaPactada}')}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(14),
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
                      child: Text(
                        '${widget.aviso.avisoHoraPactada}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(18),
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
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
                        '${widget.aviso.avisoMensaje}',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(14),
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(12),
                    ),
                    const Divider(),
                    SizedBox(
                      height: ScreenUtil().setHeight(24),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(12),
                      ),
                      child: Text(
                        'Ubicación ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(18),
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(12),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(12),
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: ScreenUtil().setHeight(40),
                            width: ScreenUtil().setHeight(40),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(EvilIcons.location),
                          ),
                          SizedBox(
                            width: ScreenUtil().setWidth(5),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(12),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(12),
                      ),
                      child: Text(
                        'Citado por ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(18),
                          fontWeight: FontWeight.w600,
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
      ),
    );
  }
}
