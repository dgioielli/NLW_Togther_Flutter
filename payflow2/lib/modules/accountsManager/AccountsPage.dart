import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:payflow/shared/keys/RouteKeys.dart';
import 'package:payflow/shared/models/ContaModel.dart';
import 'package:payflow/shared/themes/AppColors.dart';
import 'package:payflow/shared/themes/AppTextStyles.dart';
import 'package:payflow/shared/widgets/accountTile/AccountTile.dart';

class AccountsPage extends StatefulWidget {
  const AccountsPage({Key? key}) : super(key: key);

  @override
  _AccountsPageState createState() => _AccountsPageState();
}

class _AccountsPageState extends State<AccountsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: AppColors.shape,
        ),
        title: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            "Minhas Contas",
            style: AppTextStyles.titleAppBar,
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            AccountTileWidget(
              model: ContaModel(
                name: "Nova Conta",
                currentValue: 10.0,
                type: 1,
              ),
            ),
            AccountTileWidget(
              model: ContaModel(
                name: "Nova Conta",
                currentValue: 10.0,
                type: 1,
              ),
            ),
            AccountTileWidget(
              model: ContaModel(
                name: "Nova Conta",
                currentValue: 10.0,
                type: 1,
              ),
            ),
            AccountTileWidget(
              model: ContaModel(
                name: "Nova Conta",
                currentValue: 10.0,
                type: 1,
              ),
            ),
            AccountTileWidget(
              model: ContaModel(
                name: "Nova Conta",
                currentValue: 10.0,
                type: 1,
              ),
            ),
          ],
        ),
      ),
      //bottomNavigationBar: adContainer,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          print("Clicou no +1");
          await Navigator.pushNamed(context, RouteKeys.accounts_edit);
          setState(() {});
        },
        child: Icon(Icons.add_outlined),
      ),
    );
  }
}
