import 'package:flutter/cupertino.dart';
import 'package:payflow/shared/models/BoletoModel.dart';
import 'package:payflow/shared/services/BoletoService.dart';

class InsertBoletoCointroller {
  final formKey = GlobalKey<FormState>();
  BoletoModel boletoModel = BoletoModel(isPayed: false);

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

  Future<void> cadastrarBoleto() async {
    final form = formKey.currentState;
    if (form != null) {
      print("Validando");
      if (form.validate()) {
        print("Válido!");
        print(boletoModel);
        return BoletoService().saveNewBoleto(boletoModel);
      }
    }
  }
}
