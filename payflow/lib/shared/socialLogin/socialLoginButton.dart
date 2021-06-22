import 'package:flutter/material.dart';
import 'package:payflow/shared/themes/AppColors.dart';
import 'package:payflow/shared/themes/AppImages.dart';
import 'package:payflow/shared/themes/AppTextStyles.dart';

class SocialLoginButton extends StatelessWidget {
  final VoidCallback onTap;
  const SocialLoginButton({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: this.onTap,
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.shape,
            borderRadius: BorderRadius.circular(5),
            border: Border.fromBorderSide(BorderSide(color: AppColors.stroke))),
        height: 56,
        child: Row(
          children: [
            Container(
                width: 56, child: Center(child: Image.asset(AppImages.google))),
            Container(
              height: 56,
              width: 1,
              color: AppColors.stroke,
            ),
            Expanded(
              flex: 4,
              child: Text(
                "Entrar com Google",
                style: AppTextStyles.buttonGray,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
