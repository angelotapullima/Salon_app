import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salon_app/src/api/local_notification_api.dart';
import 'package:salon_app/src/bloc/provider_bloc.dart';
import 'package:salon_app/src/pages/perfil.dart';
import 'package:salon_app/src/pages/tutores/tabs/inicio_tutores_tab.dart';
import 'package:salon_app/src/utils/responsive.dart';

class HomeTutores extends StatefulWidget {
  const HomeTutores({Key? key}) : super(key: key);
  @override
  _HomeTutoresState createState() => _HomeTutoresState();
}

class _HomeTutoresState extends State<HomeTutores> {
  List<Widget> pageList = [];

  @override
  void initState() {
    pageList.add(const InicioTutores());
    pageList.add(const PerfilPage());

    super.initState();
    LocalNotificationApi.init(initScheluded: true);
    listenNotification();
  }

  void listenNotification() {
    LocalNotificationApi.onNotifications.stream.listen(onClickNotifications);
  }

  void onClickNotifications(String? playLoad) => Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => Container()),
      );

  @override
  Widget build(BuildContext context) {
    final bottomBloc = ProviderBloc.botton(context);

    final responsive = Responsive.of(context);

    return Scaffold(
      body: Stack(
        children: [
          StreamBuilder(
            stream: bottomBloc.selectPageStream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                bottomBloc.changePage(snapshot.data);
              }
              return Stack(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      bottom: kBottomNavigationBarHeight * responsive.hp(.16),
                    ),
                    child: IndexedStack(
                      index: snapshot.data,
                      children: pageList,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: kBottomNavigationBarHeight * responsive.hp(.16),
                      padding: EdgeInsets.only(
                        left: responsive.wp(2),
                        right: responsive.wp(2),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadiusDirectional.only(
                          topStart: Radius.circular(20),
                          topEnd: Radius.circular(20),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: StreamBuilder(
                        stream: bottomBloc.selectPageStream,
                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: responsive.wp(2),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      bottomBloc.changePage(0);
                                    },
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          AntDesign.home,
                                          size: responsive.ip(3),
                                          color: (bottomBloc.page == 0) ? Colors.red : Colors.grey,
                                        ),
                                        Text(
                                          'Inicio',
                                          style: TextStyle(
                                            fontSize: ScreenUtil().setSp(14),
                                            color: (bottomBloc.page == 0) ? Colors.red : Colors.grey,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      bottomBloc.changePage(1);
                                    },
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Feather.user,
                                          size: responsive.ip(3),
                                          color: (bottomBloc.page == 1) ? Colors.red : Colors.grey,
                                        ),
                                        Text(
                                          'Perfil',
                                          style: TextStyle(
                                            fontSize: ScreenUtil().setSp(14),
                                            color: (bottomBloc.page == 1) ? Colors.red : Colors.grey,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
