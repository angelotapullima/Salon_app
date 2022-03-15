import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

void showToast2(String texto, Color color) {
  Fluttertoast.showToast(msg: texto, toastLength: Toast.LENGTH_SHORT, timeInSecForIosWeb: 3, backgroundColor: color, textColor: Colors.white);
}

obtenerFecha(String date) {
  if (date == 'null' || date == '') {
    return '';
  }

  var fecha = DateTime.parse(date);

  final DateFormat fech = DateFormat('dd MMM yyyy', 'es');

  return fech.format(fecha);
}

Widget closeNodeUtil(FocusNode node) {
  return GestureDetector(
    onTap: () => node.unfocus(),
    child: Container(
      color: Colors.white,
      padding: const EdgeInsets.all(8.0),
      child: const Text(
        "Cerrar",
      ),
    ),
  );
}
