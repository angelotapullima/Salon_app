import 'package:flutter/material.dart';
import 'package:salon_app/src/api/local_notification_api.dart';
import 'package:salon_app/src/pages/docentes/home_docentes.dart';
import 'package:salon_app/src/pages/padres/home_padres.dart';
import 'package:salon_app/src/pages/tutores/home_tutores.dart';
import 'package:salon_app/src/preferencias/preferencias_usuario.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    LocalNotificationApi.init(initScheluded: true);
    listenNotification();
  }

  void listenNotification() {
    //LocalNotificationApi.onNotifications.stream.listen(onClickNotifications);
  }

// void onClickNotifications(String? playLoad) => Navigator.of(context).push(
//       MaterialPageRoute(
//         builder: (context) => DetalleAlerta(
//           idAlert: playLoad,
//         ),
//       ),
//     );

  @override
  Widget build(BuildContext context) {
    final prefs = Preferences();
    return Scaffold(
        body: (prefs.idRol == '4')
            ? const HomeDocentes()
            : (prefs.idRol == '5')
                ? const HomeTutores()
                : const HomePadre());
  }
}
