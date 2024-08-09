import 'package:flutter/material.dart';
import 'package:morflutter/design/constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatelessWidget {
  PageController _pageController = new PageController();
  OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        PageView(children: [
          Container(
            color: lilyPurple,
          ),
          Container(color: darkPeriwinkle),
          Container(color: draculaPurple),
        ]),
        Container(
            alignment: Alignment(0, 0),
            child: SmoothPageIndicator(controller: _pageController, count: 3)),
      ]),

      // DOT INDICATORS
    );
  }
}
