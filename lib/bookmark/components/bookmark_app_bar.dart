import 'package:flutter/material.dart';

class BookmarkAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BookmarkAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text("Mes favoris"),
      backgroundColor: Colors.transparent,
    );
  }
}
