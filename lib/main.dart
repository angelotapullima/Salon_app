import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salon_app/src/bloc/provider_bloc.dart';
import 'package:salon_app/src/pages/home.dart';
import 'package:salon_app/src/pages/login.dart';
import 'package:salon_app/src/pages/splash.dart';
import 'package:salon_app/src/preferencias/preferencias_usuario.dart';
import 'package:salon_app/src/preferencias/push_notifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = Preferences();
  //final prefsBufiPaymets = new PreferencesBufiPayments();

  await prefs.initPrefs();

  final firebase = FirebaseInstance();

  firebase.initConfig();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // @override
  // void initState() {
  //   super.initState();
  //   LocalNotificationApi.init(initScheluded: true);
  //   listenNotification();
  // }

  // void listenNotification() {
  //   LocalNotificationApi.onNotifications.stream.listen(onClickNotifications);
  // }

  // void onClickNotifications(String? playLoad) async => await Navigator.of(context).push(
  //       MaterialPageRoute<void>(
  //         builder: (context) => DetalleAlerta(
  //           idAlert: playLoad,
  //         ),
  //       ),
  //     );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderBloc(
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: () => MaterialApp(
          title: 'Sethi',
          theme: ThemeData(
            primarySwatch: Colors.blueGrey,
            textTheme: GoogleFonts.poppinsTextTheme(),
          ),
          debugShowCheckedModeBanner: false,
          builder: (BuildContext context, Widget? child) {
            final MediaQueryData data = MediaQuery.of(context);
            return MediaQuery(
              data: data.copyWith(textScaleFactor: data.textScaleFactor > 2.0 ? 1.2 : data.textScaleFactor),
              child: child!,
            );
          },
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('es'),
            Locale('es', 'ES'),
          ],
          localeResolutionCallback: (Locale? locale, Iterable<Locale> supportedLocales) {
            return locale;
          },
          initialRoute: 'splash',
          routes: {
            'splash': (BuildContext context) => const Splash(),
            'login': (BuildContext context) => const Login(),
            'home': (BuildContext context) => const HomePage(),
          },
        ),
      ),
    );
  }
}
