
import 'package:flutter/material.dart';

class DetalleAlerta extends StatelessWidget {
  const DetalleAlerta({Key? key, required this.idAlert}) : super(key: key);
  final String? idAlert;

  @override
  Widget build(BuildContext context) { 
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body:  Container());
  }
}
