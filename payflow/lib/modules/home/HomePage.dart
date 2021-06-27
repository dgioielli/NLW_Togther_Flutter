import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:payflow/modules/MeusBoletos/MeusBoletosPage.dart';
import 'package:payflow/modules/extract/ExtractPage.dart';
import 'package:payflow/modules/home/HomeController.dart';
import 'package:payflow/shared/models/UserModel.dart';
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
      MeusBoletosPage(key: UniqueKey()),
      ExtractPage(key: UniqueKey()),
    ];
    return Scaffold(
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
                await Navigator.pushNamed(context, "/insert_boleto");
                //Navigator.pushNamed(context, "/barcode_scanner");
                //controller.setPage(1);
                setState(() {});
              },
              child: Container(
                height: 56,
                width: 56,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: AppColors.primary),
                child:
                    Icon(Icons.add_box_outlined, color: AppColors.background),
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
    );
  }
}
