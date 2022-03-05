import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:platform_date_picker/platform_date_picker.dart';
import 'package:salon_app/src/utils/colors.dart';
import 'package:salon_app/src/utils/responsive.dart';
import 'package:salon_app/src/utils/utils.dart';

class RegistroDeIncidencia extends StatefulWidget {
  final String alumno;
  final String grado;
  final String seccion;
  const RegistroDeIncidencia({
    Key? key,
    required this.alumno,
    required this.grado,
    required this.seccion,
  }) : super(key: key);

  @override
  State<RegistroDeIncidencia> createState() => _RegistroDeIncidenciaState();
}

class _RegistroDeIncidenciaState extends State<RegistroDeIncidencia> {
  final ValueNotifier<bool> _cargando = ValueNotifier(false);
  String fechaDato = 'Seleccionar';
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _gradoController = TextEditingController();
  final TextEditingController _seccionController = TextEditingController();

  final TextEditingController _telefonoController = TextEditingController();
  final TextEditingController _direccionController = TextEditingController();

  final FocusNode _focusNombre = FocusNode();
  final FocusNode _focusNroDoc = FocusNode();
  final FocusNode _focusCodCliente = FocusNode();
  final FocusNode _focusTelefono = FocusNode();
  final FocusNode _focusDireccion = FocusNode();

  @override
  void dispose() {
    _nombreController.dispose();
    _gradoController.dispose();
    _seccionController.dispose();
    _telefonoController.dispose();
    _direccionController.dispose();
    super.dispose();
  }

  String valueSexo = 'Seleccionar';
  List<String> itemSexo = [
    'Seleccionar',
    'M',
    'F',
  ];

  @override
  void initState() {
    _nombreController.text = widget.alumno;
    _gradoController.text = widget.grado;
    _seccionController.text = widget.seccion;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          'Registro de incidencia',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: ValueListenableBuilder(
        valueListenable: _cargando,
        builder: (BuildContext context, bool data, Widget? child) {
          return Stack(
            children: [
              KeyboardActions(
                config: KeyboardActionsConfig(
                  keyboardSeparatorColor: Colors.white,
                  keyboardBarColor: Colors.white,
                  actions: [
                    KeyboardActionsItem(
                      focusNode: _focusNombre,
                      toolbarButtons: [
                        (node) {
                          return closeNode(node);
                        }
                      ],
                    ),
                    KeyboardActionsItem(
                      focusNode: _focusNroDoc,
                      toolbarButtons: [
                        (node) {
                          return closeNode(node);
                        }
                      ],
                    ),
                    KeyboardActionsItem(
                      focusNode: _focusCodCliente,
                      toolbarButtons: [
                        (node) {
                          return closeNode(node);
                        }
                      ],
                    ),
                    KeyboardActionsItem(
                      focusNode: _focusTelefono,
                      toolbarButtons: [
                        (node) {
                          return closeNode(node);
                        }
                      ],
                    ),
                    KeyboardActionsItem(
                      focusNode: _focusDireccion,
                      toolbarButtons: [
                        (node) {
                          return closeNode(node);
                        }
                      ],
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: ScreenUtil().setHeight(25),
                        ),
                        Text(
                          ' Nombre de cliente',
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(16),
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(6),
                        ),
                        TextField(
                          controller: _nombreController,
                          focusNode: _focusNombre,
                          readOnly: true,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Nombre ',
                            hintStyle: TextStyle(
                              fontSize: ScreenUtil().setSp(14),
                              color: Colors.grey[600],
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                                width: 1.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                                width: 2.0,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(
                                ScreenUtil().setWidth(10),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(20),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                ' Grado',
                                style: TextStyle(
                                  fontSize: ScreenUtil().setSp(16),
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: ScreenUtil().setWidth(15),
                            ),
                            Expanded(
                              child: Text(
                                ' Sección',
                                style: TextStyle(
                                  fontSize: ScreenUtil().setSp(16),
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(6),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                child: TextField(
                                  controller: _gradoController,
                                  focusNode: _focusNombre,
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: 'Grado ',
                                    hintStyle: TextStyle(
                                      fontSize: ScreenUtil().setSp(14),
                                      color: Colors.grey[600],
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade300,
                                        width: 1.0,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade300,
                                        width: 2.0,
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade300,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                        ScreenUtil().setWidth(10),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: ScreenUtil().setWidth(15),
                            ),
                            Expanded(
                              child: SizedBox(
                                child: TextField(
                                  controller: _seccionController,
                                  focusNode: _focusNombre,
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: 'Sección ',
                                    hintStyle: TextStyle(
                                      fontSize: ScreenUtil().setSp(14),
                                      color: Colors.grey[600],
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade300,
                                        width: 1.0,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade300,
                                        width: 2.0,
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade300,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                        ScreenUtil().setWidth(10),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(20),
                        ),
                        Text(
                          ' Fecha de Incidencia',
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(16),
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(6),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey.shade300,
                            ),
                          ),
                          padding: EdgeInsets.only(
                            right: ScreenUtil().setWidth(5),
                          ),
                          height: ScreenUtil().setHeight(50),
                          child: InkWell(
                            onTap: () {
                              _selectdate(context);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Text(
                                    fechaDato,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: (fechaDato != 'Seleccionar Todos') ? const Color(0xff5a5a5a) : colorPrimary,
                                      fontSize: ScreenUtil().setSp(16),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                const Icon(
                                  Icons.calendar_today,
                                  color: colorPrimary,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(20),
                        ),
                        Text(
                          ' Título',
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(16),
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(6),
                        ),
                        TextField(
                          controller: _telefonoController,
                          focusNode: _focusTelefono,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: ' Título',
                            hintStyle: TextStyle(
                              fontSize: ScreenUtil().setSp(14),
                              color: Colors.grey[600],
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                                width: 1.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                                width: 2.0,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(
                                ScreenUtil().setWidth(10),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(20),
                        ),
                        Text(
                          ' Detalle ',
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(16),
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(6),
                        ),
                        TextField(
                          maxLines: 3,
                          controller: _direccionController,
                          focusNode: _focusDireccion,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Detalle ',
                            hintStyle: TextStyle(
                              fontSize: ScreenUtil().setSp(14),
                              color: Colors.grey[600],
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                                width: 1.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                                width: 2.0,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(
                                ScreenUtil().setWidth(10),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(20),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            color: colorPrimary,
                            onPressed: () async {
                              if (_nombreController.text.isNotEmpty) {
                                if (valueSexo != 'Seleccionar') {
                                  if (_telefonoController.text.isNotEmpty) {
                                    if (fechaDato != 'Seleccionar') {
                                      if (_direccionController.text.isNotEmpty) {
                                        /* _cargando.value = true;
                                            final clienteApi = ClienteApi();

                                            ClienteModel clienteModel = ClienteModel();
                                            clienteModel.nombreCliente = _nombreController.text;
                                            clienteModel.tipoDocCliente = valueTipoDoc;
                                            clienteModel.nroDocCliente = _nroDocController.text;
                                            clienteModel.codigoCliente = _codigoClienteController.text;
                                            clienteModel.sexoCliente = valueSexo;
                                            clienteModel.nacimientoCLiente = fechaDato;
                                            clienteModel.telefonoCliente = _telefonoController.text;
                                            clienteModel.direccionCliente = _direccionController.text;

                                            final res = await clienteApi.saveClient(clienteModel);

                                            if (res.code == '1') {
                                              showToast2('Cliente agregado correctamente', Colors.green);
                                              final clienteBloc = ProviderBloc.cliente(context);
                                              clienteBloc.getClientForTipo('1');
                                              clienteBloc.getClientForTipo('2');
                                              Navigator.pop(context);
                                              _cargando.value = false;
                                            } else {
                                              showToast2('${res.message}', Colors.red);
                                              _cargando.value = false;
                                            } */
                                      } else {
                                        showToast2('Por favor ingrese una Dirección del cliente', Colors.red);
                                      }
                                    } else {
                                      showToast2('Por favor ingrese la fecha de nacimiento del cliente', Colors.red);
                                    }
                                  } else {
                                    showToast2('Por favor ingrese el nro de teléfono del cliente', Colors.red);
                                  }
                                } else {
                                  showToast2('Por favor seleccione el sexo del cliente', Colors.red);
                                }
                              } else {
                                showToast2('Por favor ingrese el nombre del cliente', Colors.red);
                              }
                            },
                            child: Text(
                              'Guardar',
                              style: TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(17)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(50),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              (data) ? _mostrarAlert(responsive) : Container()
            ],
          );
        },
      ),
    );
  }

  Widget _mostrarAlert(Responsive responsive) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.white.withOpacity(.5),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CupertinoActivityIndicator(),
            Text(
              'Enviando',
              //'${snapshot.data}.toInt()%',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: responsive.ip(2.4),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget dropSexo() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(5),
      ),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          border: Border.all(
            color: Colors.grey.shade300,
          )),
      child: DropdownButton<String>(
        dropdownColor: Colors.white,
        value: valueSexo,
        icon: const Icon(Icons.arrow_drop_down),
        iconSize: ScreenUtil().setSp(20),
        elevation: 16,
        isExpanded: true,
        style: TextStyle(
          color: Colors.black,
          fontSize: ScreenUtil().setSp(16),
        ),
        underline: Container(),
        onChanged: (String? data) {
          setState(() {
            valueSexo = data.toString();

            //obtenerIdNegocios(data, ciudades);
          });
        },
        items: itemSexo.map((value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              maxLines: 3,
              style: const TextStyle(color: Colors.black),
              overflow: TextOverflow.ellipsis,
            ),
          );
        }).toList(),
      ),
    );
  }

  _selectdate(BuildContext context) async {
    DateTime? picked = await showPlatformDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().month - 1),
      initialDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 2),
    );

    setState(() {
      fechaDato = "${picked!.year.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      //inputfieldDateController.text = fechaDato;

      print(fechaDato);
    });
  }
}

Widget closeNode(FocusNode node) {
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
