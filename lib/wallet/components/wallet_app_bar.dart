import 'package:flutter/material.dart';
import 'package:tripiz_app/common/constants/app_colors.dart';
import 'package:tripiz_app/common/constants/font_sizes.dart';

class WalletAppBar extends StatelessWidget implements PreferredSizeWidget {
  const WalletAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0.0,
      title: Text(
        "Mon Wallet",
        style: TextStyle(
          color: AppColors.black,
          fontSize: FontSizes.upperExtra,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.transparent,
    );
  }
}
