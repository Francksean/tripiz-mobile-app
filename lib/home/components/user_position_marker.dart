import 'package:flutter/material.dart';
import 'package:tripiz_app/common/constants/app_colors.dart';

class UserPositionMarker extends StatelessWidget {
  final double? heading;

  const UserPositionMarker({super.key, this.heading});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Cercle extérieur (style Google Maps)
        // Container(
        //   decoration: BoxDecoration(
        //     border: Border.all(color: AppColors.primary, width: 0.5),
        //     shape: BoxShape.circle,
        //     color: AppColors.primary.withOpacity(0.2),
        //   ),
        // ),
        if (heading != null)
          Transform.rotate(
            angle: (heading! * 3.14 / 180), // Conversion degrés → radians
            child: const Icon(
              Icons.navigation,
              color: AppColors.primary,
              size: 24,
            ),
          ),
      ],
    );
  }
}
