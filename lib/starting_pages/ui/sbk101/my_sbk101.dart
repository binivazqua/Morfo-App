import 'package:flutter/material.dart';
import 'package:morflutter/design/constants.dart';

class MySbk101 extends StatefulWidget {
  const MySbk101({super.key});

  @override
  State<MySbk101> createState() => _MySbk101State();
}

class _MySbk101State extends State<MySbk101> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          // MY SBK101
          children: [
            Text(
              'Mi SBK-101',
              style: TextStyle(
                  fontFamily: 'Lausane650', fontSize: 20, color: draculaPurple),
            ),

            SizedBox(height: 25),
            //RENDER
            Image(image: AssetImage('lib/design/renders/my_sbk101.png')),

            // SERIAL NUM
            Container(
              decoration: BoxDecoration(
                  color: darkPeriwinkle,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              width: 220,
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'NO.',
                    style: TextStyle(color: morfoWhite),
                  ),
                  Text(
                    '47108DEQEJ',
                    style: TextStyle(color: morfoWhite),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 20,
            ),
            // ESTADO
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'Estado:',
                  style:
                      TextStyle(fontFamily: 'Lausane650', color: draculaPurple),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Óptimo'),
                    Icon(
                      Icons.check_circle_rounded,
                      color: lilyPurple,
                    )
                  ],
                )
              ],
            )
            //BATTERY STATUS

            // CONECTIVITY STATUS

            // SERIAL NUM
          ],
        ),
      ),
    );
  }
}
