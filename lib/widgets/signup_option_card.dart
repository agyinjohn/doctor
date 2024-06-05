import 'package:flutter/material.dart';

class SignUpCardOption extends StatelessWidget {
  const SignUpCardOption({super.key, required this.img});
  final String img;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 70,
        width: 70,
        child: Card(
          color: Colors.white,
          elevation: 10,
          shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(5)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(img),
          ),
        ),
      ),
    );
  }
}
