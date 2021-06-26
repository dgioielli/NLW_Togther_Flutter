import 'package:flutter/material.dart';
import 'package:payflow/shared/themes/AppColors.dart';

class DividerVerticalWidget extends StatelessWidget {
  const DividerVerticalWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      color: AppColors.stroke,
      width: 1,
    );
  }
}
