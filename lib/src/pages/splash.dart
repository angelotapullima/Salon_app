import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salon_app/src/bloc/provider_bloc.dart';
import 'package:salon_app/src/preferencias/preferencias_usuario.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () async {
      final preferences = Preferences();

      final bottomBloc = ProviderBloc.botton(context);
      bottomBloc.changePage(0);
      if (preferences.idUser == null || preferences.idUser.isEmpty) {
        Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false);
      } else {
        Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const SizedBox.expand(),
          Center(
            child: SizedBox(
              height: ScreenUtil().setHeight(550),
              child: Image(
                image: AssetImage('assets/img/logo.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
