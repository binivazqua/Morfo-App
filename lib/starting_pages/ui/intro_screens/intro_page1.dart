import 'package:flutter/material.dart';
import 'package:morflutter/design/constants.dart';

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
                  'lib/design/logos/cuadrado_blanco_trippypurple-removebg-preview.png')),
          Text(
            'Welcome to MORFO!',
            style: TextStyle(color: morfoBlack, fontFamily: 'Lausane'),
          ),
        ],
      ),
    );
  }
}
