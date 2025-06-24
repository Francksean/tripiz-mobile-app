import 'package:flutter/material.dart';
import 'package:tripiz_app/common/constants/app_colors.dart';

class DotIndicator extends StatelessWidget {
  final bool isActive;

  const DotIndicator({required this.isActive, super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 8,
      width: isActive ? 24 : 8,
      decoration: BoxDecoration(
        color: isActive ? AppColors.primary : AppColors.black,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}
