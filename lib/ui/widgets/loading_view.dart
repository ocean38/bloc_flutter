import 'package:flutter/material.dart';
import 'package:impacteer/utils/app_colors.dart';

class LoadingView extends StatelessWidget {
  final double? value;
  const LoadingView({Key? key, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.black.withOpacity(0.5),
      alignment: Alignment.center,
      child: CircularProgressIndicator(color: AppColors.white, value: value),
    );
  }
}
