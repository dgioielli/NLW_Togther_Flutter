import 'package:payflow/shared/keys/PreferencesKeys.dart';
import 'package:payflow/shared/models/BoletoModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BoletoService {
  Future<List<BoletoModel>> getBoletos() async {
    try {
      final instance = await SharedPreferences.getInstance();
      final response =
          instance.getStringList(PreferencesKeys.boletos) ?? <String>[];
      final boletos = response.map((e) => BoletoModel.fromJson(e)).toList();
      //final dates = boletos.map((e) => e.getDueDate()).toList();
      //print(dates);
      return boletos;
    } catch (e) {
      return <BoletoModel>[];
    }
  }

  Future<void> saveNewBoleto(BoletoModel boletoModel) async {
    try {
      final boletos = await getBoletos();
      boletos.add(boletoModel);
      await saveBoletos(boletos);
    } catch (e) {}
  }

  Future<void> saveUpdateBoleto(BoletoModel model) async {
    try {
      final boletos = await getBoletos();
      final oldModel =
          boletos.firstWhere((element) => element.name == model.name);
      boletos.remove(oldModel);
      boletos.add(model);
      await saveBoletos(boletos);
    } catch (e) {}
  }

  Future<void> deleteBoleto(BoletoModel model) async {
    try {
      final boletos = await getBoletos();
      final oldModel =
          boletos.firstWhere((element) => element.name == model.name);
      boletos.remove(oldModel);
      await saveBoletos(boletos);
    } catch (e) {}
  }

  Future<void> saveBoletos(List<BoletoModel> boletos) async {
    try {
      boletos.sort((a, b) => a.getDueDate().compareTo(b.getDueDate()));
      final jsonBoletos = boletos.map((e) => e.toJson()).toList();
      final instance = await SharedPreferences.getInstance();
      await instance.setStringList(PreferencesKeys.boletos, jsonBoletos);
    } catch (e) {}
  }
}
