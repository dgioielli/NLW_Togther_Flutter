import 'package:flutter/material.dart';
import 'package:payflow/shared/keys/TypeAccountsKeys.dart';
import 'package:payflow/shared/models/ContaModel.dart';
import 'package:payflow/shared/themes/AppColors.dart';
import 'package:payflow/shared/themes/AppTextStyles.dart';

enum WhyFarther { harder, smarter, selfStarter, tradingCharter }

class AccountTileWidget extends StatelessWidget {
  final ContaModel model;
  const AccountTileWidget({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 2.5,
        horizontal: 5,
      ),
      child: Card(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: Row(
                children: [
                  Expanded(
                      child: Text(
                    "${model.name}",
                    style: AppTextStyles.titleListTile,
                  )),
                  Text(
                    "R\$ ${model.currentValue == null ? model.currentValue!.toStringAsFixed(2) : 0.0.toStringAsFixed(2)}",
                    style: AppTextStyles.titleListTile,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: Text(
                    "${TypeAccountsKeys().getString(model.typeEnum)}",
                    style: AppTextStyles.captionBody,
                  )),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      color: AppColors.shape,
                      child: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
