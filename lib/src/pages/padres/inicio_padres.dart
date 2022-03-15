import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salon_app/src/bloc/provider_bloc.dart';
import 'package:salon_app/src/pages/Content/Citaciones/citaciones_content.dart';
import 'package:salon_app/src/pages/Content/Incidencias/incidencias_content.dart';
import 'package:salon_app/src/pages/Content/actividades/actividades_content.dart';
import 'package:salon_app/src/pages/padres/tabs/select_hijos.dart';
import 'package:salon_app/src/utils/colors.dart';
import 'package:salon_app/src/utils/responsive.dart';

import '../../preferencias/preferencias_usuario.dart';

class InicioPadre extends StatefulWidget {
  static final _controller = Controller();
  const InicioPadre({Key? key}) : super(key: key);

  @override
  State<InicioPadre> createState() => _InicioPadreState();
}

class _InicioPadreState extends State<InicioPadre> {
  @override
  Widget build(BuildContext context) {
    final prefs = Preferences();
    final responsive = Responsive.of(context);
    final hijoBloc = ProviderBloc.hijo(context);
    hijoBloc.validarHijos();
    return Scaffold(
      backgroundColor: const Color(0xfff1eff6),
      body: StreamBuilder(
          stream: hijoBloc.validarHijosStream,
          builder: (context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.hasData) {
              return SafeArea(
                child: AnimatedBuilder(
                  animation: InicioPadre._controller,
                  builder: (context, t) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: ScreenUtil().setHeight(8),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setWidth(10),
                          ),
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                            CircleAvatar(
                              radius: responsive.ip(2),
                              child: ClipOval(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: CachedNetworkImage(
                                    placeholder: (context, url) => const SizedBox(
                                      width: double.infinity,
                                      height: double.infinity,
                                      child: Image(image: AssetImage('assets/img/profile.png'), fit: BoxFit.cover),
                                    ),
                                    errorWidget: (context, url, error) => SizedBox(
                                      child: SizedBox(
                                        child: Image.asset(
                                          'assets/img/profile.png',
                                          fit: BoxFit.cover,
                                          width: ScreenUtil().setWidth(150),
                                          height: ScreenUtil().setHeight(150),
                                        ),
                                      ),
                                    ),
                                    imageUrl: '${prefs.image}}',
                                    imageBuilder: (context, imageProvider) => Container(
                                      decoration: BoxDecoration(
                                        //border: Border.all(color: Colors.red, width: ScreenUtil().setWidth(3)),
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const Spacer(),
                          ]),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setWidth(10),
                          ),
                          child: Text(
                            'Bienvenido, ${prefs.personName}',
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(20),
                              color: const Color(0xff323a54),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                opaque: false,
                                transitionDuration: const Duration(milliseconds: 400),
                                pageBuilder: (context, animation, secondaryAnimation) {
                                  return const SelectHijos();
                                },
                                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                  return FadeTransition(
                                    opacity: animation,
                                    child: child,
                                  );
                                },
                              ),
                            );

                            //SelectHijos
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: ScreenUtil().setWidth(10),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  'Padre de ${prefs.hijoNombre}',
                                  style: TextStyle(
                                    fontSize: ScreenUtil().setSp(12),
                                    color: const Color(0xff323a54),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Icon(Icons.arrow_drop_down),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(10),
                        ),
                        tabAnimated(),
                        SizedBox(
                          height: ScreenUtil().setHeight(20),
                        ),
                        Expanded(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40),
                            ),
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  topRight: Radius.circular(40),
                                ),
                              ),
                              child: (InicioPadre._controller.valueBoton == 1)
                                  ? const ActividadesContent(
                                      esHijo: true,
                                    )
                                  : (InicioPadre._controller.valueBoton == 2)
                                      ? const IncideciasContent(
                                          esHijo: true,
                                        )
                                      : const CitacionesContent(
                                          esHijo: true,
                                        ),
                            ),
                          ),
                        )
                      ],
                    );
                  },
                ),
              );
            } else {
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            }
          }),
    );
  }

  Container tabAnimated() {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(20),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(3),
        vertical: ScreenUtil().setWidth(3),
      ),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
        color: tabUnSelected,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: tabUnSelected),
      ),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                InicioPadre._controller.changeValueBoton(1);
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: ScreenUtil().setHeight(7),
                  horizontal: ScreenUtil().setWidth(2),
                ),
                decoration: BoxDecoration(
                  color: (InicioPadre._controller.valueBoton == 1) ? tabSelected : tabUnSelected,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    'Actividades',
                    style: GoogleFonts.poppins(
                      color: (InicioPadre._controller.valueBoton == 1) ? colorTextSelect : colorTextUnSelect,
                      fontWeight: FontWeight.w500,
                      fontSize: ScreenUtil().setSp(14),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                InicioPadre._controller.changeValueBoton(2);
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: ScreenUtil().setHeight(7),
                  horizontal: ScreenUtil().setWidth(2),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: (InicioPadre._controller.valueBoton == 2) ? tabSelected : tabUnSelected,
                ),
                child: Center(
                  child: Text(
                    'Incidencias',
                    style: GoogleFonts.poppins(
                      color: (InicioPadre._controller.valueBoton == 2) ? colorTextSelect : colorTextUnSelect,
                      fontWeight: FontWeight.w500,
                      fontSize: ScreenUtil().setSp(14),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                InicioPadre._controller.changeValueBoton(3);
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: ScreenUtil().setHeight(7),
                  horizontal: ScreenUtil().setWidth(2),
                ),
                decoration: BoxDecoration(
                  color: (InicioPadre._controller.valueBoton == 3) ? tabSelected : tabUnSelected,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    'Citaciones',
                    style: GoogleFonts.poppins(
                      color: (InicioPadre._controller.valueBoton == 3) ? colorTextSelect : colorTextUnSelect,
                      fontWeight: FontWeight.w500,
                      fontSize: ScreenUtil().setSp(14),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Controller extends ChangeNotifier {
  int valueBoton = 1;

  void changeValueBoton(int v) {
    valueBoton = v;
    notifyListeners();
  }
}
