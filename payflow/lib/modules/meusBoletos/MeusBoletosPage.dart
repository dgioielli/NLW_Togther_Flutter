import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';
import 'package:payflow/modules/home/HomeController.dart';
import 'package:payflow/shared/models/BoletoModel.dart';
import 'package:payflow/shared/themes/AppColors.dart';
import 'package:payflow/shared/themes/AppTextStyles.dart';
import 'package:payflow/shared/widgets/boletoInfo/BoletoInfoWidget.dart';
import 'package:payflow/shared/widgets/boletoList/BoletoListController.dart';
import 'package:payflow/shared/widgets/boletoList/BoletoListWidget.dart';

class MeusBoletosPage extends StatefulWidget {
  final HomeController homeController;
  const MeusBoletosPage({Key? key, required this.homeController})
      : super(key: key);

  @override
  _MeusBoletosPageState createState() => _MeusBoletosPageState();
}

class _MeusBoletosPageState extends State<MeusBoletosPage> {
  final BoletoListController controller = BoletoListController();

  //_MeusBoletosPageState({required this.controller});

  @override
  Widget build(BuildContext context) {
    final onTap = (BoletoModel boleto) {
      print(boleto.name);
      widget.homeController.editBoleto = boleto;
    };
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 80,
            child: Stack(
              children: [
                Container(
                  color: AppColors.primary,
                  height: 40,
                ),
                ValueListenableBuilder<List<BoletoModel>>(
                    valueListenable: controller.boletosNotifier,
                    builder: (_, boletos, __) => AnimatedCard(
                        direction: AnimatedCardDirection.top,
                        child: BoletoInfoWidget(size: boletos.length))),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 24,
              left: 24,
              right: 24,
            ),
            child: Row(
              children: [
                Text(
                  "Meus Boletos",
                  style: AppTextStyles.titleBoldHeading,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Divider(
              color: AppColors.stroke,
              thickness: 2,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: BoletoListWidget(
              controller: controller,
              onTap: onTap,
            ),
          ),
        ],
      ),
    );
  }
}
