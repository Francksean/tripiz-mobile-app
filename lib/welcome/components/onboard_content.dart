import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tripiz_app/common/constants/app_colors.dart';
import 'package:tripiz_app/common/constants/font_sizes.dart';
import 'package:tripiz_app/common/constants/font_weights.dart';

class OnBoardContent extends StatelessWidget {
  final String image;
  final String titleTop;
  final String titleBottom;

  const OnBoardContent({
    required this.image,
    required this.titleTop,
    required this.titleBottom,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Image SVG centrée et responsive
        Center(
          child: SvgPicture.asset(
            image,
            height: MediaQuery.of(context).size.height * 0.6,
            fit: BoxFit.cover,
          ),
        ),

        // Texte positionné en bas
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Column(
            children: [
              Text(
                titleTop,
                style: TextStyle(
                  fontSize: FontSizes.lowerLarge,
                  color: AppColors.black,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                titleBottom,
                style: TextStyle(
                  fontSize: FontSizes.upperExtra,
                  fontWeight: FontWeights.bold,
                  color: AppColors.vantablack,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
