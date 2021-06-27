import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:payflow/modules/insertBoleto/InsertBoletoController.dart';
import 'package:payflow/shared/themes/AppColors.dart';
import 'package:payflow/shared/themes/AppTextStyles.dart';
import 'package:payflow/shared/widgets/SetLabelButtons.dart';
import 'package:payflow/shared/widgets/inputText/InputTextWidget.dart';

class InsertBoletoPage extends StatefulWidget {
  final String? barcode;
  const InsertBoletoPage({Key? key, this.barcode}) : super(key: key);

  @override
  _InsertBoletoPageState createState() => _InsertBoletoPageState();
}

class _InsertBoletoPageState extends State<InsertBoletoPage> {
  final moneyInputController = MoneyMaskedTextController(
    leftSymbol: "R\$",
    decimalSeparator: ",",
  );
  final dueDateInputController = MaskedTextController(mask: "00/00/0000");
  final barcodeInputController = TextEditingController();
  final controller = InsertBoletoCointroller();

  @override
  void initState() {
    if (widget.barcode != null) {
      barcodeInputController.text = widget.barcode!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: BackButton(
          color: AppColors.input,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 73, vertical: 24),
                child: Text(
                  "Preencha os dados do Boleto:",
                  style: AppTextStyles.titleBoldHeading,
                  textAlign: TextAlign.center,
                ),
              ),
              Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    InputTextWidget(
                      label: "Nome do Boleto",
                      icon: Icons.description_outlined,
                      onChanged: (value) {
                        controller.onChanged(name: value);
                      },
                      validator: controller.validateName,
                    ),
                    InputTextWidget(
                      label: "Vencimento",
                      icon: FontAwesomeIcons.timesCircle,
                      onChanged: (value) {
                        controller.onChanged(dueDate: value);
                      },
                      controller: dueDateInputController,
                      validator: controller.validateVencimento,
                      //icon: Icons.description_outlined,
                    ),
                    InputTextWidget(
                      label: "Valor",
                      icon: FontAwesomeIcons.wallet,
                      onChanged: (value) {
                        controller.onChanged(
                            value: moneyInputController.numberValue);
                      },
                      controller: moneyInputController,
                      validator: (_) => controller
                          .validateValor(moneyInputController.numberValue),
                    ),
                    InputTextWidget(
                      label: "Código",
                      icon: FontAwesomeIcons.barcode,
                      onChanged: (value) {
                        controller.onChanged(barcode: value);
                      },
                      controller: barcodeInputController,
                      validator: controller.validateCodigo,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 57,
        child: Column(
          children: [
            Expanded(
              child: Container(
                height: 1,
                color: AppColors.stroke,
              ),
            ),
            SetLabelButtons(
              primaryLabel: "Cancelar",
              primaryOnPressed: () {
                Navigator.pop(context);
              },
              secondaryLabel: "Cadastrar",
              secondaryOnPressed: () async {
                print("clicou");
                await controller.cadastrarBoleto();
                Navigator.pop(context);
              },
              enableSecondaryColor: true,
            ),
          ],
        ),
      ),
    );
  }
}
