import 'package:flutter/cupertino.dart';
import 'package:payflow/shared/models/BoletoModel.dart';
import 'package:payflow/shared/services/BoletoService.dart';

class BoletoListController {
  final boletosNotifier = ValueNotifier<List<BoletoModel>>(<BoletoModel>[]);
  List<BoletoModel> get boletos => boletosNotifier.value;
  set boletos(List<BoletoModel> value) => boletosNotifier.value = value;

  BoletoListController() {
    loadBoletos();
  }

  Future<void> loadBoletos() async {
    boletos = await BoletoService().getBoletos();
  }
}
