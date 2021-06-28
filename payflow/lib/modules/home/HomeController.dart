import 'package:flutter/cupertino.dart';
import 'package:payflow/shared/models/BoletoModel.dart';

class HomeController {
  final editBoletoNotifier = ValueNotifier<BoletoModel?>(null);
  var currentPage = 0;
  BoletoModel? get editBoleto => editBoletoNotifier.value;
  set editBoleto(BoletoModel? value) => editBoletoNotifier.value = value;

  void setPage(int index) {
    currentPage = index;
  }
}
