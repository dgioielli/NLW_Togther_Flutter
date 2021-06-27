import 'package:flutter/material.dart';
import 'package:payflow/shared/models/BoletoModel.dart';
import 'package:payflow/shared/widgets/boletoList/BoletoListController.dart';
import 'package:payflow/shared/widgets/boletoTile/BoletoTileWidget.dart';

class BoletoListWidget extends StatefulWidget {
  final BoletoListController controller;
  const BoletoListWidget({Key? key, required this.controller})
      : super(key: key);

  @override
  _BoletoListWidgetState createState() =>
      _BoletoListWidgetState(controller: controller);
}

class _BoletoListWidgetState extends State<BoletoListWidget> {
  final BoletoListController controller;

  _BoletoListWidgetState({required this.controller});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller.boletosNotifier,
      builder: (_, boletos, __) => Column(
        children:
            controller.boletos.map((e) => BoletoTileWidget(model: e)).toList(),
      ),
    );
  }
}
