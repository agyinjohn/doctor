import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({required String this.text, this.onPressed, super.key});
  final String text;
  final void Function()? onPressed;
  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.bottomRight,
              colors: [Colors.blue, Colors.blue])),
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
            shape:
                BeveledRectangleBorder(borderRadius: BorderRadius.circular(0)),
            shadowColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            fixedSize: const Size(395, 55)),
        child: Text(
          widget.text,
          style: const TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }
}
