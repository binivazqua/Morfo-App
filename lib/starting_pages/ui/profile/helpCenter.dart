import 'package:flutter/material.dart';
import 'package:morflutter/design/constants.dart';

class helpCenterPage extends StatelessWidget {
  const helpCenterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: lilyPurple,
        title: Image(
            image: AssetImage(
              'lib/design/logos/rectangular_vino_trippypurplep.png',
            ),
            width: 120),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              'Recibe soporte técnico ',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Row(
                children: [
                  Icon(Icons.question_answer_rounded),
                  SizedBox(
                    width: 10,
                  ),
                  Text('Pregunta 1')
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
