import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:morflutter/design/constants.dart';

class IntroPage3 extends StatelessWidget {
  const IntroPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: morfoBlack,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Image(
          image: AssetImage('lib/design/renders/mantainance.png'),
          width: 250,
        ).animate().fadeIn(
              curve: Curves.easeInToLinear,
              duration: Duration(milliseconds: 1500),
              delay: Duration(milliseconds: 350),
            ),
        SizedBox(
          height: 30,
        ),
        Text(
          'Y centro de asistencia remoto',
          style: TextStyle(color: morfoWhite),
        ).animate().slideY(
            delay: Duration(milliseconds: 100),
            begin: 1.5,
            duration: Duration(milliseconds: 600)),
        SizedBox(height: 10),
        Text(
          'Para aprovechar al máximo tu SBK1-01',
          style: TextStyle(
              color: morfoWhite.withOpacity(0.5), fontStyle: FontStyle.italic),
        ).animate().slideY(
            delay: Duration(milliseconds: 100),
            begin: 1.5,
            duration: Duration(milliseconds: 600)),
        SizedBox(height: 10),
      ]),
    );
  }
}
