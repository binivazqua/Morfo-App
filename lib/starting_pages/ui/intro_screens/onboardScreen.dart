import 'package:flutter/material.dart';
import 'package:morflutter/design/constants.dart';
import 'package:morflutter/display_info/databaseLink.dart';
import 'package:morflutter/starting_pages/auth/authPage.dart';
import 'package:morflutter/starting_pages/auth/loginPage.dart';
import 'package:morflutter/starting_pages/auth/mainPage.dart';
import 'package:morflutter/starting_pages/ui/intro_screens/intro_page1.dart';
import 'package:morflutter/starting_pages/ui/intro_screens/intro_page2.dart';
import 'package:morflutter/starting_pages/ui/intro_screens/intro_page3.dart';
import 'package:morflutter/starting_pages/ui/sbk101/about_sbk101.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  final VoidCallback onFinish;
  OnboardingScreen({super.key, required this.onFinish});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController _pageController = new PageController();

  // keep track of page in which we are.
  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        PageView(
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 2);
              });
            },
            controller: _pageController,
            children: [IntroPage1(), IntroPage2(), IntroPage3()]),
        Container(
            alignment: Alignment(0, 0.65),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Skip
                GestureDetector(
                  child: Text(
                    "Omitir",
                    style: TextStyle(color: morfoWhite),
                  ),
                  // Go to last page
                  onTap: () {
                    _pageController.jumpToPage(2);
                  },
                ),
                // Page indicator
                SmoothPageIndicator(controller: _pageController, count: 3),

                // Prev

                // Next
                onLastPage
                    ? GestureDetector(
                        child: Text(
                          "Hecho",
                          style: TextStyle(color: morfoWhite),
                        ),
                        // go next
                        // Go to last page
                        onTap: () {
                          widget.onFinish();
                        },
                      )
                    : GestureDetector(
                        child: Text(
                          "Siguiente",
                          style: TextStyle(color: morfoWhite),
                        ),
                        // go next
                        // Go to last page
                        onTap: () {
                          _pageController.nextPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeIn);
                        },
                      ),
              ],
            )),
      ]),

      // DOT INDICATORS
    );
  }
}
