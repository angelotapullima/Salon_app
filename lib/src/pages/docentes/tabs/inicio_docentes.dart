import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salon_app/src/pages/padres/Citaciones/citaciones_content.dart';
import 'package:salon_app/src/pages/padres/actividades/actividades_content.dart';
import 'package:salon_app/src/pages/tutores/Aulas/aulas_content.dart';
import 'package:salon_app/src/utils/colors.dart';

class InicioDocentes extends StatelessWidget {
  static final _controller = Controller();
  const InicioDocentes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: const Color.fromARGB(255, 245, 246, 248),
      backgroundColor: const Color(0xfff1eff6),
      body: SafeArea(
        child: AnimatedBuilder(
          animation: _controller,
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
                  child: Row(children: [
                    const CircleAvatar(
                      backgroundColor: Colors.teal,
                    ),
                    const Spacer(),
                    const Icon(Fontisto.search),
                    SizedBox(width: ScreenUtil().setWidth(8)),
                  ]),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(10),
                  ),
                  child: Text(
                    'Bienvenido, Carlos',
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(20),
                      color: const Color(0xff323a54),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(10),
                  ),
                  child: Text(
                    'Papá de  Carlos Jr, 6° B',
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(12),
                      color: const Color(0xff323a54),
                      fontWeight: FontWeight.bold,
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
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: (_controller.valueBoton == 1)
                        ? const AulasTutores(valor: '2')
                        : (_controller.valueBoton == 2)
                            ? const CitacionesContent()
                            : const ActividadesContent(),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  Container tabAnimated() {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(10),
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
                _controller.changeValueBoton(1);
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: ScreenUtil().setHeight(7),
                  horizontal: ScreenUtil().setWidth(2),
                ),
                decoration: BoxDecoration(
                  color: (_controller.valueBoton == 1) ? tabSelected : tabUnSelected,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      FontAwesome5Brands.servicestack,
                      size: ScreenUtil().setSp(17),
                      color: (_controller.valueBoton == 1) ? Colors.red : Colors.grey,
                    ),
                    SizedBox(
                      width: ScreenUtil().setWidth(5),
                    ),
                    Text(
                      'Aulas',
                      style: GoogleFonts.poppins(
                        color: (_controller.valueBoton == 1) ? colorTextSelect : colorTextUnSelect,
                        fontWeight: FontWeight.w500,
                        fontSize: ScreenUtil().setSp(12.5),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                _controller.changeValueBoton(2);
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: ScreenUtil().setHeight(7),
                  horizontal: ScreenUtil().setWidth(2),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: (_controller.valueBoton == 2) ? tabSelected : tabUnSelected,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      AntDesign.paperclip,
                      size: ScreenUtil().setSp(17),
                      color: (_controller.valueBoton == 2) ? Colors.red : Colors.grey,
                    ),
                    SizedBox(
                      width: ScreenUtil().setWidth(5),
                    ),
                    Text(
                      'Citaciones',
                      style: GoogleFonts.poppins(
                        color: (_controller.valueBoton == 2) ? colorTextSelect : colorTextUnSelect,
                        fontWeight: FontWeight.w500,
                        fontSize: ScreenUtil().setSp(12.5),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                _controller.changeValueBoton(3);
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: ScreenUtil().setHeight(7),
                  horizontal: ScreenUtil().setWidth(2),
                ),
                decoration: BoxDecoration(
                  color: (_controller.valueBoton == 3) ? tabSelected : tabUnSelected,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Fontisto.paper_plane,
                      size: ScreenUtil().setSp(17),
                      color: (_controller.valueBoton == 3) ? Colors.red : Colors.grey,
                    ),
                    SizedBox(
                      width: ScreenUtil().setWidth(5),
                    ),
                    Text(
                      'Actividades',
                      style: GoogleFonts.poppins(
                        color: (_controller.valueBoton == 3) ? colorTextSelect : colorTextUnSelect,
                        fontWeight: FontWeight.w500,
                        fontSize: ScreenUtil().setSp(12.5),
                      ),
                    ),
                  ],
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
