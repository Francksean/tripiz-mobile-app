import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripiz_app/bookmark/components/bookmark_app_bar.dart';
import 'package:tripiz_app/bookmark/screens/bookmark_screen.dart';
import 'package:tripiz_app/common/constants/app_colors.dart';
import 'package:tripiz_app/home/components/home_appbar.dart';
import 'package:tripiz_app/home/screens/home_screen.dart';
import 'package:tripiz_app/profile/components/profile_app_bar.dart';
import 'package:tripiz_app/profile/screens/profile_screen.dart';
import 'package:tripiz_app/wallet/components/wallet_app_bar.dart';
import 'package:tripiz_app/wallet/screens/wallet_screen.dart';

class CommonScaffold extends StatefulWidget {
  const CommonScaffold({super.key});

  @override
  State<CommonScaffold> createState() => _CommonScaffoldState();
}

class _CommonScaffoldState extends State<CommonScaffold> {
  var _selectedIndex = 0;

  void _updateSelectedIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<PreferredSizeWidget> appBars = [
    const HomeAppbar(),
    const WalletAppBar(),
    const BookmarkAppBar(),
    const ProfileAppBar(),
  ];
  final List<Widget> pages = [
    const HomeScreen(),
    const WalletScreen(),
    const BookmarkScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: true,
      appBar: appBars[_selectedIndex],
      body: pages[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        elevation: 2,
        onDestinationSelected: _updateSelectedIndex,
        destinations: const [
          NavigationDestination(
            selectedIcon: Icon(Icons.home_filled, color: AppColors.primary),
            icon: Icon(Icons.home_outlined, color: AppColors.black),
            label: "Home",
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.account_balance_wallet,
              color: AppColors.primary,
            ),
            icon: Icon(
              Icons.account_balance_wallet_outlined,
              color: AppColors.black,
            ),
            label: "wallet",
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.bookmark, color: AppColors.primary),
            icon: Icon(Icons.bookmark_border_outlined, color: AppColors.black),
            label: "Favoris",
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.person, color: AppColors.primary),
            icon: Icon(Icons.person_outline, color: AppColors.black),
            label: "compte",
          ),
        ],
      ),
    );
  }
}
