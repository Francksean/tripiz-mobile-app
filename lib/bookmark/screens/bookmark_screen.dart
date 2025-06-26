import 'package:flutter/material.dart';
import 'package:tripiz_app/common/constants/app_colors.dart';
import 'package:tripiz_app/common/constants/font_sizes.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({super.key});

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 15.0,
        right: 15.0,
        top: kToolbarHeight + 40,
      ),
      child: Column(
        children: [
          Text(
            "Accédez rapidement à vos destinations favorites",
            style: TextStyle(
              color: AppColors.black,
              fontSize: FontSizes.lowerBig,
            ),
          ),
        ],
      ),
    );
  }
}
