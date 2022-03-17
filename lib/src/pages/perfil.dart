import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salon_app/src/pages/docentes/tabs/perfil_docentes.dart';
import 'package:salon_app/src/pages/padres/tabs/perfil_padres.dart';
import 'package:salon_app/src/pages/tutores/tabs/perfil_tutores.dart';
import 'package:salon_app/src/preferencias/preferencias_usuario.dart';
import 'package:salon_app/src/utils/constants.dart';

class PerfilPage extends StatelessWidget {
  const PerfilPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final prefs = Preferences();
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(24)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: ScreenUtil().setHeight(50),
            ),
            Center(
              child: SizedBox(
                width: ScreenUtil().setWidth(200),
                height: ScreenUtil().setHeight(200),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CachedNetworkImage(
                    placeholder: (context, url) => const SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: Image(image: AssetImage('assets/img/profile.png'), fit: BoxFit.cover),
                    ),
                    errorWidget: (context, url, error) => SizedBox(
                      child: Image.asset(
                        'assets/img/profile.png',
                        fit: BoxFit.cover,
                        width: ScreenUtil().setWidth(150),
                        height: ScreenUtil().setHeight(150),
                      ),
                    ),
                    imageUrl: '$apiBaseURL/${prefs.image}',
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.red, width: ScreenUtil().setWidth(3)),
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
            SizedBox(
              height: ScreenUtil().setHeight(8),
            ),
            Center(
              child: Text(
                '${prefs.personName} ${prefs.personSurname}',
                style: GoogleFonts.poppins(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w700,
                  color: Colors.blueAccent,
                  fontSize: ScreenUtil().setSp(18),
                ),
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(30),
            ),
            _data(FontAwesome5.user, '${prefs.rolNombre}'),
            SizedBox(
              height: ScreenUtil().setHeight(10),
            ),
            _data(Entypo.email, '${prefs.userEmail}'),
            SizedBox(
              height: ScreenUtil().setHeight(10),
            ),
            _data(Entypo.documents, 'Términos y políticas de uso'),
            SizedBox(
              height: ScreenUtil().setHeight(10),
            ),
            _data(MaterialIcons.help_outline, 'Ayuda'),
            SizedBox(
              height: ScreenUtil().setHeight(10),
            ),
            _data(MaterialIcons.system_update, '1.0.0'),
            const Spacer(),
            SizedBox(
              height: ScreenUtil().setHeight(20),
            ),
            (prefs.idRol == '4')
                ? const PerfilDocentes()
                : (prefs.idRol == '5')
                    ? const PerfilTutores()
                    : const PerfilPadres(),
            SizedBox(
              height: ScreenUtil().setHeight(30),
            ),
          ],
        ),
      ),
    );
  }

  Row _data(IconData icon, String data) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.red,
          size: ScreenUtil().setSp(25),
        ),
        SizedBox(
          width: ScreenUtil().setWidth(12),
        ),
        Text(
          data,
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: ScreenUtil().setSp(16),
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
