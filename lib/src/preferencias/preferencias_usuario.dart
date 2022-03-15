import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static final Preferences _instancia = Preferences._internal();

  factory Preferences() {
    return _instancia;
  }

  SharedPreferences? _prefs;

  Preferences._internal();

  initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  clearPreferences() async {
    await _prefs!.clear();
  }

  get hijoId {
    return _prefs!.getString('hijoId');
  }

  set hijoIds(String value) {
    _prefs!.setString('hijoId', value);
  }

  get hijoNombre {
    return _prefs!.getString('hijoNombre');
  }

  set hijoNombres(String value) {
    _prefs!.setString('hijoNombre', value);
  }

  

  get idUser {
    return _prefs!.getString('id_user');
  }

  set idUsers(String value) {
    _prefs!.setString('id_user', value);
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

  get versionApp {
    return _prefs!.getString('versionApp');
  }

  set versionApps(String value) {
    _prefs!.setString('versionApp', value);
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
}
