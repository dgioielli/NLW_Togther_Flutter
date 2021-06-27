import 'package:flutter/cupertino.dart';
import 'package:payflow/shared/models/BoletoModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InsertBoletoCointroller {
  final formKey = GlobalKey<FormState>();
  BoletoModel boletoModel = BoletoModel();

  String? validateName(String? value) =>
      value?.isEmpty ?? true ? "O nome não pode ser vazio" : null;
  String? validateVencimento(String? value) =>
      value?.isEmpty ?? true ? "A data de vencimento não pode ser vazio" : null;
  String? validateValor(double value) =>
      value == 0 ? "Insira um valor maior que R\$ 0,00" : null;
  String? validateCodigo(String? value) =>
      value?.isEmpty ?? true ? "O código do boleto não pode ser vazio" : null;

  void onChanged(
      {String? name, String? dueDate, double? value, String? barcode}) {
    boletoModel = boletoModel.copyWith(
      name: name,
      dueDate: dueDate,
      value: value,
      barcode: barcode,
    );
  }

  Future<void> saveBoleto() async {
    try {
      final instance = await SharedPreferences.getInstance();
      final boletos = instance.getStringList("boletos") ?? <String>[];
      boletos.add(boletoModel.toJson());
      await instance.setStringList("boletos", boletos);
    } catch (e) {}
  }

  Future<void> cadastrarBoleto() async {
    final form = formKey.currentState;
    if (form != null) {
      print("Validando");
      if (form.validate()) {
        print("Válido!");
        print(boletoModel);
        return saveBoleto();
      }
    }
  }
}
