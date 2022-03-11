import 'package:rxdart/rxdart.dart';
import 'package:salon_app/src/api/aula_api.dart';
import 'package:salon_app/src/database/aula_database.dart';
import 'package:salon_app/src/models/salon_tutor_model.dart';

class AulaBloc {
  final aulaDatabase = AulaDatabase();
  final aulaApi =AulaApi();
  final _aulaController = BehaviorSubject<List<AulaModel>>();

  Stream<List<AulaModel>> get aulaStream => _aulaController.stream;

  dispose() {
    _aulaController.close();
  }

  void getAulas() async {
    _aulaController.sink.add(await aulaDatabase.getAulas());
    await aulaApi.getAulas();
    _aulaController.sink.add(await aulaDatabase.getAulas());
  }
}
