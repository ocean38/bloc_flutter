import 'package:flutter/material.dart';
import 'package:impacteer/utils/app_colors.dart';

class DetailsImageView extends StatelessWidget {
  final String? image;
  const DetailsImageView({super.key, this.image});

  @override
  Widget build(BuildContext context) {
    final containerHeight = MediaQuery.of(context).size.height / 2.2;

    return Stack(
      children: [
        /// image
        if (image?.isNotEmpty ?? false)
          Container(
            height: containerHeight,
            decoration: BoxDecoration(
              color: AppColors.themeColor,
              image: DecorationImage(
                image: NetworkImage(image ?? ''),
                fit: BoxFit.fill,
              ),
            ),
          ),

        ///
        Container(
          height: containerHeight,
          color: AppColors.themeColor.withOpacity(0.9),
        ),
      ],
    );
  }
}
