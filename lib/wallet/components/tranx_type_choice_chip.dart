import 'package:flutter/material.dart';
import 'package:tripiz_app/common/constants/app_colors.dart';

class TranxTypeChoiceChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onSelected;

  const TranxTypeChoiceChip({
    required this.label,
    required this.isSelected,
    required this.onSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(
        label,
        style: TextStyle(
          color: isSelected ? AppColors.white : AppColors.secondary,
          fontWeight: FontWeight.bold,
        ),
      ),
      selected: isSelected,
      onSelected: (_) => onSelected(),
      selectedColor: AppColors.secondary,
      backgroundColor: AppColors.background,
      showCheckmark: false,
      side: BorderSide.none,
    );
  }
}
