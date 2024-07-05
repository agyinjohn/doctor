import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {required this.prefix,
      this.isPass = false,
      required this.hintText,
      required this.controller,
      super.key});
  final Icon prefix;
  final bool isPass;
  final String hintText;
  final TextEditingController controller;
  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isHidden = true;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.isPass ? isHidden : false,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
          hintText: widget.hintText,
          prefixIcon: widget.prefix,
          suffixIcon: widget.isPass
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      isHidden = !isHidden;
                    });
                  },
                  icon: isHidden
                      ? const Icon(Icons.visibility_off_sharp)
                      : const Icon(Icons.visibility))
              : null,
          filled: true,
          fillColor: Colors.white,
          enabledBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return "Please provide ${widget.hintText}";
          }
          return null;
        },
      ),
    );
  }
}
