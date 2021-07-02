import 'package:flutter/material.dart';
import 'package:payflow/shared/models/ContaModel.dart';
import 'package:payflow/shared/themes/AppColors.dart';
import 'package:payflow/shared/themes/AppTextStyles.dart';
import 'package:payflow/shared/widgets/accountTile/AccountTile.dart';

class AccountsPage extends StatelessWidget {
  const AccountsPage({Key? key}) : super(key: key);

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
    );
  }
}
