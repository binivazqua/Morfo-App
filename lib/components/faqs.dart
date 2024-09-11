import 'package:flutter/material.dart';

class faqsContainer extends StatelessWidget {
  const faqsContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
