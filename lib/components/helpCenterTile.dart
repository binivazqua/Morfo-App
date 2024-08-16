import 'package:flutter/material.dart';
import 'package:morflutter/design/constants.dart';

class helpCenterType extends StatelessWidget {
  const helpCenterType({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: lilyPurple, borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [Text('Name')],
        ),
      ),
    );
  }
}
