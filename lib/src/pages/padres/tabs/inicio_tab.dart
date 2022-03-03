import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salon_app/src/models/incidencias_padres.dart';
import 'package:salon_app/src/utils/colors.dart';

class InicioPadre extends StatelessWidget {
  static final _controller = Controller();
  const InicioPadre({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 246, 248),
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
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    const CircleAvatar(
                      backgroundColor: Colors.teal,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey.shade300,
                          ),
                          borderRadius: BorderRadius.circular(5)),
                      height: ScreenUtil().setHeight(50),
                      width: ScreenUtil().setHeight(50),
                      child: Center(
                        child: Stack(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                const SizedBox(),
                                const Icon(Fontisto.bell),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(width: ScreenUtil().setWidth(15)),
                                Container(
                                  height: ScreenUtil().setHeight(18),
                                  width: ScreenUtil().setHeight(18),
                                  //padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(10)),
                                  decoration: const BoxDecoration(
                                    color: Colors.blue,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Center(
                                    child: Text(
                                      '3',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ]),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(10),
                  ),
                  child: Text(
                    'Bienvenido, Angelo',
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(20),
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(10),
                  ),
                  child: Text(
                    'Papá de  Angelo Jr, 6° B',
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(12),
                      color: Colors.black,
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
                        ? const SizedBox(
                            child: Center(
                              child: Text('Actividades'),
                            ),
                          )
                        : (_controller.valueBoton == 2)
                            ? incidenciasContent()
                            : const SizedBox(
                                child: Center(
                                  child: Text('Citaciones'),
                                ),
                              ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  Widget incidenciasContent() {
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
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: listIncidencias[index].lista!.length,
                      itemBuilder: (context, index2) {
                        return Container(
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
                          padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(2), horizontal: ScreenUtil().setWidth(4)),
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
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: ScreenUtil().setSp(12)),
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
                                style: TextStyle(fontSize: ScreenUtil().setSp(13)),
                              ),
                            ],
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
                child: Center(
                  child: Text(
                    'Actividades',
                    style: GoogleFonts.poppins(
                      color: (_controller.valueBoton == 1) ? colorTextSelect : colorTextUnSelect,
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
                child: Center(
                  child: Text(
                    'Incidencias',
                    style: GoogleFonts.poppins(
                      color: (_controller.valueBoton == 2) ? colorTextSelect : colorTextUnSelect,
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
                child: Center(
                  child: Text(
                    'Citaciones',
                    style: GoogleFonts.poppins(
                      color: (_controller.valueBoton == 3) ? colorTextSelect : colorTextUnSelect,
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
