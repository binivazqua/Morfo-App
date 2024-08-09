import 'package:flutter/material.dart';
import 'package:morflutter/design/constants.dart';

class niceTextField extends StatefulWidget {
  final String dataRequired;
  final TextEditingController textController;
  final double p;
  const niceTextField(
      {super.key,
      required this.dataRequired,
      required this.textController,
      required this.p});

  @override
  State<niceTextField> createState() => _niceTextFieldState();
}

class _niceTextFieldState extends State<niceTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: widget.p),
      child: Container(
        decoration: BoxDecoration(
            color: lilyPurple,
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(colors: [lilyPurple, darkPeriwinkle])),
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: TextField(
            controller: widget.textController,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: widget.dataRequired,
                hintStyle: TextStyle(color: draculaPurple)),
          ),
        ),
      ),
    );
  }
}
