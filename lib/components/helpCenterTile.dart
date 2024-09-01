import 'package:flutter/material.dart';
import 'package:morflutter/design/constants.dart';

class helpCenterType extends StatelessWidget {
  final String service;
  final Icon icon;
  final MaterialPageRoute goTo;
  const helpCenterType(
      {super.key,
      required this.service,
      required this.icon,
      required this.goTo});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[400], borderRadius: BorderRadius.circular(20)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            icon,
            TextButton(
              child: Text(
                service,
                style: TextStyle(color: draculaPurple),
              ),
              onPressed: () {
                Navigator.push(context, goTo);
              },
            ),
          ],
        ),
      ),
    );
  }
}
