import 'package:flutter/material.dart';
import 'package:tripiz_app/common/constants/app_colors.dart';

class HomeAppbar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppbar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // flexibleSpace: Container(
      //   decoration: BoxDecoration(
      //     gradient: LinearGradient(
      //       begin: Alignment.topCenter,
      //       end: Alignment.bottomCenter,
      //       colors: [
      //         AppColors.white,
      //         Color.fromARGB(169, 255, 255, 255),
      //         Color.fromARGB(103, 255, 255, 255),
      //         Color.fromARGB(0, 255, 255, 255),
      //       ],
      //     ),
      //   ),
      // ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }
}
