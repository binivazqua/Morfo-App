import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:morflutter/design/constants.dart';

class IntroPage2 extends StatelessWidget {
  const IntroPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: morfoBlack,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: AssetImage('lib/design/renders/data_vis_morfo.png'),
            width: 250,
          ).animate().fadeIn(
                curve: Curves.easeInToLinear,
                duration: Duration(milliseconds: 1500),
                delay: Duration(milliseconds: 350),
              ),
          /*.shimmer(
              duration: Duration(milliseconds: 500),
              delay: Duration(seconds: 1),
              color: lilyPurple,
              size: 50),*/ //.moveY(duration: Duration(seconds: 1)),
          SizedBox(
            height: 30,
          ),
          Text(
            'Tu asistente de rehabilitación',
            style: TextStyle(color: morfoWhite),
          ).animate().slideY(
              delay: Duration(milliseconds: 100),
              begin: 1.5,
              duration: Duration(milliseconds: 600)),
          SizedBox(height: 10),
          Text(
            'Asesorado por profesionales',
            style: TextStyle(
                color: morfoWhite.withOpacity(0.5),
                fontStyle: FontStyle.italic),
          ).animate().slideY(
              delay: Duration(milliseconds: 100),
              begin: 1.5,
              duration: Duration(milliseconds: 600)),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
