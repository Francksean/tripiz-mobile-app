import 'package:flutter/material.dart';
import 'package:tripiz_app/common/components/custom_image_picker.dart';
import 'package:tripiz_app/common/constants/app_colors.dart';

class AvatarModifier extends StatefulWidget {
  const AvatarModifier({super.key});

  @override
  State<AvatarModifier> createState() => _AvatarModifierState();
}

class _AvatarModifierState extends State<AvatarModifier> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          child: Container(
            height: 120,
            width: 120,
            margin: const EdgeInsets.only(bottom: 20),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/profile_img.jpg"),
              ),
              shape: BoxShape.circle,
              color: AppColors.border,
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          right: 0,
          child: CustomImagePicker(
            imageHandler: (image) {},
            label: "Votre phote de profil",
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.black,
                shape: BoxShape.circle,
                border: Border.all(width: 3, color: AppColors.black),
              ),
              child: Icon(
                Icons.border_color_outlined,
                color: AppColors.white,
                size: 15,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
