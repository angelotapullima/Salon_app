import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AulasTutores extends StatelessWidget {
  const AulasTutores({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.only(
        top: ScreenUtil().setHeight(20),
        left: ScreenUtil().setWidth(20),
        right: ScreenUtil().setWidth(15),
      ),
      itemCount: 55,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 1,
        crossAxisCount: 3,
        mainAxisSpacing: ScreenUtil().setHeight(10),
        crossAxisSpacing: ScreenUtil().setWidth(5),
      ),
      itemBuilder: (context, index) {
        return Container(
          color: Colors.teal.withOpacity(.5),
          child: Center(
            child: Text('Salon $index'),
          ),
        );
      },
    );
  }
}
