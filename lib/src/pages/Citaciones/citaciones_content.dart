import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salon_app/src/bloc/provider_bloc.dart';
import 'package:salon_app/src/models/aviso_model.dart';
import 'package:salon_app/src/pages/Citaciones/citaciones_detail.dart';
import 'package:salon_app/src/utils/responsive.dart';

class CitacionesContent extends StatelessWidget {
  const CitacionesContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final citacionesBloc = ProviderBloc.citaciones(context);
    citacionesBloc.getCitaciones();
    return SafeArea(
      child: StreamBuilder(
        stream: citacionesBloc.citacionesStream,
        builder: (context, AsyncSnapshot<List<CitacionesMoldel>> alertas) {
          if (alertas.hasData) {
            if (alertas.data!.isNotEmpty) {
              return _itemFechaAlert(context, alertas.data!);
            } else {
              return const Center(
                child: Text('No tiene ningún pendiente para hoy en la agenda'),
              );
            }
          } else {
            return const Center(child: CupertinoActivityIndicator());
          }
        },
      ),
    );
  }

  Widget _itemFechaAlert(BuildContext context, List<CitacionesMoldel> fechas) {
    final responsive = Responsive.of(context);

    return ListView.builder(
      padding: EdgeInsets.only(
        bottom: responsive.hp(5),
        top: responsive.hp(3),
      ),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: fechas.length,
      itemBuilder: (context, y) {
        return SizedBox(
          child: ListView.builder(
            padding: EdgeInsets.only(
              bottom: responsive.hp(3),
            ),
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: 1,
            itemBuilder: (context, x) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: responsive.wp(19),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: responsive.wp(2),
                        vertical: responsive.hp(2),
                      ),
                      child: Text(
                        '${fechas[y].fecha}',
                        style: GoogleFonts.poppins(
                          fontSize: ScreenUtil().setSp(16),
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          letterSpacing: ScreenUtil().setSp(0.016),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(0),
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: fechas[y].citaciones!.length,
                        /*  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 1,
                          crossAxisCount: 2,
                          mainAxisSpacing: responsive.hp(1),
                          crossAxisSpacing: responsive.wp(5),
                        ), */
                        itemBuilder: (context, i) {
                          return _itemCitaciones(context, fechas[y].citaciones![i], responsive);
                        },
                      ),
                    ),
                  ),
                ],
              );
              //return _cardCanchas(responsive, canchasDeporte[i], negocio);
            },
          ),
        );
      },
    );
  }

  Widget _itemCitaciones(BuildContext context, AvisoModel aviso, Responsive responsive) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            opaque: false,
            transitionDuration: const Duration(milliseconds: 400),
            pageBuilder: (context, animation, secondaryAnimation) {
              return CitacionesDetail(aviso: aviso);
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
            horizontal: responsive.wp(2),
          ),
          margin: EdgeInsets.only(
            right: responsive.wp(2),
            bottom: responsive.hp(.5),
            top: responsive.hp(.5),
          ),
          decoration: BoxDecoration(
            color: Colors.blueGrey.shade100.withOpacity(.2),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${aviso.aulaGrado} ${aviso.aulaSeccion} - ${aviso.aulaNivel}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${aviso.avisoHoraPactada}',
                style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${aviso.avisoMensaje}',
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(13),
                ),
              ),
              const Text(''),
            ],
          )),
    );
  }
}
