




import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static final Preferences _instancia = new Preferences._internal();

  factory Preferences() {
    return _instancia;
  }

  SharedPreferences? _prefs;

  Preferences._internal();

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  clearPreferences() async {
    final prefs = Preferences();

    var version = prefs.versionApp;
    var yape = prefs.nombreYape;
    var plin = prefs.nombrePlin;
    var numero = prefs.numeroPagoOnline;
    await _prefs!.clear();

    prefs.versionApps = version;
    prefs.nombreYapes = yape;
    prefs.nombrePlins = plin;
    prefs.numeroPagoOnlines = numero;
  }

  get estadoCargaInicial {
    return _prefs!.getString('estadoCargaInicial') ;
  }

  set estadoCargaInicials(String value) {
    _prefs!.setString('estadoCargaInicial', value);
  }

  get nombrePlin {
    return   _prefs!.getString('nombrePlin') ?? "";
  }

  set nombrePlins(String value) {
    _prefs!.setString('nombrePlin', value);
  }

  set onScrolls(bool value) {
    _prefs!.setBool('onScroll', value);
  }

  get onScroll {
    return   _prefs!.getBool('onScroll') ?? "";
  }

  get nombreYape {
    return  _prefs!.getString('nombreYape') ?? "";
  }

  set nombreYapes(String value) {
    _prefs!.setString('nombreYape', value);
  }

  get numeroPagoOnline {
    return  _prefs!.getString('numeroPagoOnline') ?? "";
  }

  set numeroPagoOnlines(String value) {
    _prefs!.setString('numeroPagoOnline', value);
  }

  get codigoUser {
    return  _prefs!.getString('codigoUser') ?? "";
  }

  set codigoUsers(String value) {
    _prefs!.setString('codigoUser', value);
  }

  get apellidoPaterno {
    return  _prefs!.getString('apellidoPaterno') ?? "";
  }

  set apellidoPaternos(String value) {
    _prefs!.setString('apellidoPaterno', value);
  }

  get apellidoMaterno {
    return _prefs!.getString('apellidoMaterno') ?? "";
  }

  set apellidoMaternos(String value) {
    _prefs!.setString('apellidoMaterno', value);
  }

  get fechaCreacion {
    return _prefs!.getString('fechaCreacion');
  }

  set fechaCreacions(String value) {
    _prefs!.setString('fechaCreacion', value);
  }

  get idUser {
    return _prefs!.getString('id_user');
  }

  set idUsers(String value) {
    _prefs!.setString('id_user', value);
  }
/* 
  get password {
    return _prefs!.getString('password')?? "";
  }

  set passwords(String value) {
    _prefs!.setString('password', value);
  } */

  get idPerson {
    _prefs!.getString('id_person');
  }

  set idPersons(String value) {
    _prefs!.setString('id_person', value);
  }

  get userNickname {
    return _prefs!.getString('user_nickname');
  }

  set userNicknames(String value) {
    _prefs!.setString('user_nickname', value);
  }

  get userEmail {
    return _prefs!.getString('user_email');
  }

  set userEmails(String value) {
    _prefs!.setString('user_email', value);
  }

  get userEmailValidateCode {
    return _prefs!.getString('user_email_validate_code');
  }

  set userEmailValidateCodes(String value) {
    _prefs!.setString('user_email_validate_code', value);
  }

  get image {
    return _prefs!.getString('image');
  }

  set images(String value) {
    _prefs!.setString('image', value);
  }

  get personName {
    return _prefs!.getString('person_name');
  }

  set personNames(String value) {
    _prefs!.setString('person_name', value);
  }

  get personSurname {
    return _prefs!.getString('person_surname');
  }

  set personSurnames(String value) {
    _prefs!.setString('person_surname', value);
  }

  get personDni {
    return _prefs!.getString('person_dni');
  }

  set personDnis(String value) {
    _prefs!.setString('person_dni', value);
  }

  get personBirth {
    return _prefs!.getString('person_birth');
  }

  set personBirths(String value) {
    _prefs!.setString('person_birth', value);
  }

  get personNumberPhone {
    return _prefs!.getString('person_number_phone');
  }

  set personNumberPhones(String value) {
    _prefs!.setString('person_number_phone', value);
  }

  get personGenre {
    return _prefs!.getString('person_genre');
  }

  set personGenres(String value) {
    _prefs!.setString('person_genre', value);
  }

  get personNacionalidad {
    return _prefs!.getString('person_nacionalidad');
  }

  set personNacionalidads(String value) {
    _prefs!.setString('person_nacionalidad', value);
  }

  get rolNombre {
    return _prefs!.getString('rol_nombre');
  }

  set rolNombres(String value) {
    _prefs!.setString('rol_nombre', value);
  }

  get idRol {
    return _prefs!.getString('id_rol');
  }

  set idRols(String value) {
    _prefs!.setString('id_rol', value);
  }

  get personAddress {
    return _prefs!.getString('person_address');
  }

  set personAddresss(String value) {
    _prefs!.setString('person_address', value);
  }

  get versionApp {
    return _prefs!.getString('versionApp');
  }

  set versionApps(String value) {
    _prefs!.setString('versionApp', value);
  }

  get userNum {
    return _prefs!.getString('user_num');
  }

  set userNums(String value) {
    _prefs!.setString('user_num', value);
  }

  get userPosicion {
    return _prefs!.getString('user_posicion');
  }

  set userPosicions(String value) {
    _prefs!.setString('user_posicion', value);
  }

  get userHabilidad {
    return _prefs!.getString('user_habilidad');
  }

  set userHabilidads(String value) {
    _prefs!.setString('user_habilidad', value);
  }
/* 
  get ubigeoId2 {
    return _prefs.getString('ubigeo_id');
  }

  set ubigeoId2(String value) {
    _prefs.setString('ubigeo_id', value);
  } */

  get tieneNegocio {
    return _prefs!.getString('tiene_negocio');
  }

  set tieneNegocios(String value) {
    _prefs!.setString('tiene_negocio', value);
  }

  get token {
    return _prefs!.getString('token');
  }

  set tokens(String value) {
    _prefs!.setString('token', value);
  }

  get tokenFirebase {
    return _prefs!.getString('token_firebase');
  }

  set tokenFirebases(String value) {
    _prefs!.setString('token_firebase', value);
  }

  get ciudadID {
    return _prefs!.getString('ciudadID');
  }

  set ciudadIDs(String value) {
    _prefs!.setString('ciudadID', value);
  }

  //torneoID
  //preferencia para guardar el id del torneo que visita, ya sea para editaro o visualizarlo
  get torneoID {
    return _prefs!.getString('torneoID');
  }

  set torneoIDs(String value) {
    _prefs!.setString('torneoID', value);
  }

  get imagenTorneo {
    return _prefs!.getString('imagenTorneo');
  }

  set imagenTorneos(String value) {
    _prefs!.setString('imagenTorneo', value);
  }

  set torneoIDimagenTorneos(String value) {
    _prefs!.setString('imagenTorneo', value);
  }

  get imagenLogoTorneo {
    return _prefs!.getString('imagenLogoTorneo');
  }

  set imagenLogoTorneos(String value) {
    _prefs!.setString('imagenLogoTorneo', value);
  }

  //categoriaID
  //preferencia para guardar el id de la categoría o subtorneo que visita, ya sea para editaro o visualizarlo
  /* get categoriaID {
    return _prefs.getString('categoriaID');
  }

  set categoriaID(String value) {
    _prefs.setString('categoriaID', value);
  } */

  get categoriaIDU {
    return _prefs!.getString('categoriaIDU');
  }

  set categoriaIDUs(String value) {
    _prefs!.setString('categoriaIDU', value);
  }

  get miTorneo {
    return _prefs!.getString('miTorneo');
  }

  set miTorneos(String value) {
    _prefs!.setString('miTorneo', value);
  }

  get validarCrearTorneo {
    return _prefs!.getString('validarCrearTorneo');
  }

  set validarCrearTorneos(String value) {
    _prefs!.setString('validarCrearTorneo', value);
  }

  get idFecha {
    return _prefs!.getString('idFecha');
  }

  set idFechas(String value) {
    _prefs!.setString('idFecha', value);
  }

  get nombreFecha {
    return _prefs!.getString('nombreFecha');
  }

  set nombreFechas(String value) {
    _prefs!.setString('nombreFecha', value);
  }

  get idUserBufiPay {
    return _prefs!.getString('idUserBufiPay');
  }

  set idUserBufiPays(String value) {
    _prefs!.setString('idUserBufiPay', value);
  }
}
