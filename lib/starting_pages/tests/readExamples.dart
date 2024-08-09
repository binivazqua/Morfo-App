import 'package:flutter/material.dart';

class ReadExamples extends StatefulWidget {
  const ReadExamples({super.key});

  @override
  State<ReadExamples> createState() => _ReadExamplesState();
}

class _ReadExamplesState extends State<ReadExamples> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Read Examples'),
        backgroundColor: Colors.purple[200],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
