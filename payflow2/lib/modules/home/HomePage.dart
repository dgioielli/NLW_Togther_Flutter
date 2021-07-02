import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:payflow/modules/MeusBoletos/MeusBoletosPage.dart';
import 'package:payflow/modules/extract/ExtractPage.dart';
import 'package:payflow/modules/home/HomeController.dart';
import 'package:payflow/shared/models/BoletoModel.dart';
import 'package:payflow/shared/models/UserModel.dart';
import 'package:payflow/shared/services/BoletoService.dart';
import 'package:payflow/shared/themes/AppColors.dart';
import 'package:payflow/shared/themes/AppTextStyles.dart';

class HomePage extends StatefulWidget {
  final UserModel user;
  const HomePage({Key? key, required this.user}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = HomeController();

  @override
  Widget build(BuildContext context) {
    var pages = [
      MeusBoletosPage(
        key: UniqueKey(),
        homeController: controller,
      ),
      ExtractPage(key: UniqueKey()),
    ];
    return Stack(
      children: [
        Scaffold(
          body: pages[controller.currentPage],
          appBar: PreferredSize(
            child: Container(
              height: 152,
              color: AppColors.primary,
              child: Center(
                child: ListTile(
                  title: Text.rich(TextSpan(
                      text: "Olá, ",
                      style: AppTextStyles.titleRegular,
                      children: [
                        TextSpan(
                            text: "${widget.user.name}!",
                            style: AppTextStyles.titleBoldBackground)
                      ])),
                  subtitle: Text(
                    "Mantenha suas contas em dia",
                    style: AppTextStyles.captionShape,
                  ),
                  trailing: Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                        image: NetworkImage(widget.user.photoUrl!),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            preferredSize: Size.fromHeight(152),
          ),
          bottomNavigationBar: Container(
            height: 90,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    onPressed: () {
                      controller.setPage(0);
                      setState(() {});
                    },
                    icon: Icon(Icons.home,
                        color: controller.currentPage == 0
                            ? AppColors.primary
                            : AppColors.body)),
                GestureDetector(
                  onTap: () async {
                    print("Clicou!");
                    //await Navigator.pushNamed(context, "/insert_boleto");
                    await Navigator.pushNamed(context, "/barcode_scanner");
                    //controller.setPage(1);
                    setState(() {});
                  },
                  child: Container(
                    height: 56,
                    width: 56,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: AppColors.primary),
                    child: Icon(Icons.add_box_outlined,
                        color: AppColors.background),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    controller.setPage(1);
                    setState(() {});
                  },
                  icon: Icon(
                    Icons.description_outlined,
                    color: controller.currentPage == 1
                        ? AppColors.primary
                        : AppColors.body,
                  ),
                )
              ],
            ),
          ),
        ),
        ValueListenableBuilder<BoletoModel?>(
            valueListenable: controller.editBoletoNotifier,
            builder: (_, editBoleto, __) {
              if (editBoleto == null) return Container();
              var value = editBoleto.value;
              if (value == null) value = 0;
              return Material(
                color: Colors.transparent,
                child: Container(
                  color: Colors.black.withOpacity(0.4),
                  child: Column(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            print("Clicou na tela");
                            controller.editBoleto = null;
                          },
                          child: Container(),
                        ),
                      ),
                      Container(
                        height: 300,
                        color: AppColors.background,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 75,
                                vertical: 30,
                              ),
                              child: Text.rich(
                                TextSpan(
                                  text: "O boleto ",
                                  style: AppTextStyles.titleHeading,
                                  children: [
                                    TextSpan(
                                      text: "${editBoleto.name}",
                                      style: AppTextStyles.titleBoldHeading,
                                    ),
                                    TextSpan(text: " no valor de "),
                                    TextSpan(
                                      text: "R\$ ${value.toStringAsFixed(2)}",
                                      style: AppTextStyles.titleBoldHeading,
                                    ),
                                    TextSpan(text: " já foi pago?"),
                                  ],
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    width: 155,
                                    height: 55,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: AppColors.shape,
                                    ),
                                    child: TextButton(
                                      onPressed: () {
                                        controller.editBoleto = null;
                                      },
                                      child: Center(
                                          child: Text(
                                        "Ainda não",
                                        style: AppTextStyles.buttonGray,
                                      )),
                                    ),
                                  ),
                                  Container(
                                    width: 155,
                                    height: 55,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: AppColors.primary,
                                    ),
                                    child: TextButton(
                                      onPressed: () {
                                        final updateBoleto = controller
                                            .editBoleto!
                                            .copyWith(isPayed: true);
                                        BoletoService()
                                            .saveUpdateBoleto(updateBoleto);
                                        controller.editBoleto = null;
                                        setState(() {});
                                      },
                                      child: Center(
                                          child: Text(
                                        "Sim",
                                        style:
                                            AppTextStyles.buttonBoldBackground,
                                      )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Container(
                                color: AppColors.stroke,
                                height: 2,
                              ),
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: AppColors.shape,
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    final barcode =
                                        controller.editBoleto!.barcode ??
                                            "Nenhum Código";
                                    print(barcode);
                                    Clipboard.setData(ClipboardData(
                                      text: barcode,
                                    ));
                                  },
                                  child: Center(
                                      child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Copiar código de barras",
                                        style: AppTextStyles.buttonPrimary,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20.0),
                                        child: Icon(
                                          FontAwesomeIcons.clone,
                                          color: AppColors.primary,
                                          size: 15,
                                        ),
                                      ),
                                    ],
                                  )),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 0),
                              child: Container(
                                color: AppColors.stroke,
                                height: 2,
                              ),
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: AppColors.shape,
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    BoletoService()
                                        .deleteBoleto(controller.editBoleto!);
                                    controller.editBoleto = null;
                                    setState(() {});
                                  },
                                  child: Center(
                                      child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20.0),
                                        child: Icon(
                                          FontAwesomeIcons.trash,
                                          color: AppColors.delete,
                                          size: 15,
                                        ),
                                      ),
                                      Text(
                                        "Deletar Boleto",
                                        style: AppTextStyles.buttonDelete,
                                      ),
                                    ],
                                  )),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ],
    );
  }
}
