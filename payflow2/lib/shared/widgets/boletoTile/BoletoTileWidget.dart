import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';
import 'package:payflow/shared/models/BoletoModel.dart';
import 'package:payflow/shared/themes/AppTextStyles.dart';

class BoletoTileWidget extends StatelessWidget {
  final BoletoModel model;
  final void Function(BoletoModel)? onTap;
  const BoletoTileWidget({Key? key, required this.model, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isVencido =
        model.getDueDate().isBefore(DateTime.now()) && model.isPayed != true;
    return AnimatedCard(
      direction: AnimatedCardDirection.right,
      child: InkWell(
        onTap: () {
          if (onTap != null) onTap!(model);
        },
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(
            model.name!,
            style: AppTextStyles.titleListTile,
          ),
          subtitle: Text(
            isVencido
                ? "Venceu em ${model.dueDate}"
                : "Vence em ${model.dueDate}",
            style: isVencido
                ? AppTextStyles.titleListTileVencido
                : AppTextStyles.titleListTile,
          ),
          trailing: Text.rich(TextSpan(
            text: "R\$ ",
            style: AppTextStyles.trailingRegular,
            children: [
              TextSpan(
                text: "${model.value!.toStringAsFixed(2)}",
                style: AppTextStyles.trailingBold,
              ),
            ],
          )),
        ),
      ),
    );
  }
}
