import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:morflutter/design/constants.dart';
import 'package:morflutter/starting_pages/ui/intro_screens/intro_page3.dart';

class IntroPage1 extends StatelessWidget {
  const IntroPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
              colors: [darkPeriwinkle, lilyPurple, draculaPurple])),
      // color: morfoWhite,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
                  width: 200,
                  image: AssetImage(
                      'lib/design/logos/cuadrado_blanco_trippypurple-removebg-preview.png'))
              .animate()
              .fadeIn(
                  delay: Duration(milliseconds: 500),
                  duration: Duration(milliseconds: 1500)),
          /*
              .moveY(
                delay: Duration(milliseconds: 200),
                duration: Duration(milliseconds: 1000),
              ),*/
          /*
              .flip(
                  delay: Duration(milliseconds: 500),
                  duration: Duration(milliseconds: 700)),*/
          Text(
            '¡Dile hola a tu asistente ortopédico!',
            style: TextStyle(color: morfoWhite, fontFamily: 'Lausane650'),
          ).animate().fadeIn(
              delay: Duration(milliseconds: 500),
              duration: Duration(milliseconds: 1500)),
        ],
      ),
    );
  }
}
