import 'package:flutter/material.dart';
import 'package:payflow/modules/barcodeSacnner/BarcodeScannerController.dart';
import 'package:payflow/modules/barcodeSacnner/BarcodeScannerStatus.dart';
import 'package:payflow/shared/themes/AppColors.dart';
import 'package:payflow/shared/themes/AppTextStyles.dart';
import 'package:payflow/shared/widgets/DividerVerticalWidget.dart';
import 'package:payflow/shared/widgets/LabelButton.dart';
import 'package:payflow/shared/widgets/SetLabelButtons.dart';
import 'package:payflow/shared/widgets/bottomSheet/Bottom_sheet.dart';

class BarcodeScannerPage extends StatefulWidget {
  const BarcodeScannerPage({Key? key}) : super(key: key);

  @override
  _BarcodeScannerPageState createState() => _BarcodeScannerPageState();
}

class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
  final controller = BarcodeScannerController();

  @override
  void initState() {
    controller.getAvailableCameras();
    controller.statusNotifier.addListener(() {
      if (controller.status.hasBarcode) {
        Navigator.pushReplacementNamed(context, "/insert_boleto");
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ValueListenableBuilder<BarcodeScannerStatus>(
          valueListenable: controller.statusNotifier,
          builder: (_, status, __) {
            if (status.showCamera) {
              return Container(
                child: controller.cameraController!.buildPreview(),
              );
            } else {
              return Container();
            }
          },
        ),
        SafeArea(
          child: RotatedBox(
            quarterTurns: 1,
            child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  centerTitle: true,
                  backgroundColor: Colors.black,
                  title: Text(
                    "Escaneie o código de barras do boleto",
                    style: AppTextStyles.buttonBoldBackground,
                  ),
                  leading: BackButton(
                    color: AppColors.background,
                  ),
                ),
                body: Column(
                  children: [
                    Expanded(
                      child: Container(
                        color: Colors.black.withOpacity(0.8),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        color: Colors.transparent,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.black.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
                bottomNavigationBar: Container(
                  color: AppColors.background,
                  child: SetLabelButtons(
                    primaryLabel: "Digitar código de barras",
                    primaryOnPressed: () {
                      Navigator.pushReplacementNamed(context, "/insert_boleto");
                    },
                    secondaryLabel: "Adicionar da galeria",
                    secondaryOnPressed: () {},
                  ),
                )),
          ),
        ),
        ValueListenableBuilder<BarcodeScannerStatus>(
          valueListenable: controller.statusNotifier,
          builder: (_, status, __) {
            if (status.hasError) {
              return Bottom_Sheet(
                title: 'Não foi possível identificar o código de barras!',
                subTitle:
                    'Tente escanear novamente ou digite o código do seu boleto.',
                primaryLabel: 'Escanear novamente',
                primaryOnPressed: () {
                  controller.scanWithCamera();
                },
                secondaryLabel: 'Digitar Código',
                secondaryOnPressed: () {
                  Navigator.pushReplacementNamed(
                    context,
                    "/insert_boleto",
                    arguments: controller.status.barcode,
                  );
                },
              );
            } else {
              return Container(
                color: Colors.transparent,
              );
            }
          },
        ),
      ],
    );
  }
}
