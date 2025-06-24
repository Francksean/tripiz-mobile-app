import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tripiz_app/common/constants/app_colors.dart';
import 'package:tripiz_app/welcome/components/dot_indicator.dart';
import 'package:tripiz_app/welcome/components/onboard_content.dart';

class OnBoard {
  final String image, titleTop, titleBottom;

  OnBoard({
    required this.image,
    required this.titleTop,
    required this.titleBottom,
  });
}

// OnBoarding content list
final List<OnBoard> onbDatas = [
  OnBoard(
    image: "assets/onb-1.svg",
    titleTop: "Optimisez votre",
    titleBottom: "Emploi du temps",
  ),
  OnBoard(
    image: "assets/onb-2.svg",
    titleTop: "Gérez vos",
    titleBottom: "Trajets urbains",
  ),
  OnBoard(
    image: "assets/onb-3.svg",
    titleTop: "Gérez vos",
    titleBottom: "Dépenses transports",
  ),
];

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late PageController _pageController;
  int _pageIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    // _startAutoScroll();
  }

  // void _startAutoScroll() {
  //   _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
  //     if (_pageController.hasClients) {
  //       final nextPage = _pageIndex < onbDatas.length - 1 ? _pageIndex + 1 : 0;
  //       _pageController.animateToPage(
  //         nextPage,
  //         duration: const Duration(milliseconds: 500),
  //         curve: Curves.easeInOut,
  //       );
  //     }
  //   });
  // }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              width: double.infinity,
              // NOTE : temporary slide behavior
              child: PageView.builder(
                onPageChanged: (index) => setState(() => _pageIndex = index),
                itemCount: onbDatas.length,
                controller: _pageController,
                itemBuilder:
                    (context, index) => OnBoardContent(
                      titleTop: onbDatas[_pageIndex].titleTop,
                      titleBottom: onbDatas[_pageIndex].titleBottom,
                      image: onbDatas[_pageIndex].image,
                    ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 20,
              ),
              child: Row(
                //list padding in include to some
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                children: [
                  GestureDetector(
                    onTap: () {
                      if (_pageIndex > 0) {
                        setState(() {
                          _pageIndex -= 1;
                        });
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: AppColors.primary,
                        size: 12,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      onbDatas.length,
                      (index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: DotIndicator(isActive: index == _pageIndex),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (_pageIndex < onbDatas.length - 1) {
                        setState(() {
                          _pageIndex += 1;
                        });
                      } else {
                        context.go("/app");
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.primary,
                        size: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
