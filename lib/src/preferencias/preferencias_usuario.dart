




import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static final Preferences _instancia =  Preferences._internal();

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



  get idUser {
    return _prefs!.getString('id_user');
  }

  set idUsers(String value) {
    _prefs!.setString('id_user', value);
  }
  

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
